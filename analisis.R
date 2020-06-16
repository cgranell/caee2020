library(likert)
library(tidyverse)
library(here)
library(readxl)
library(lubridate)
library(scales)

folder_figs <- "figs"
folder_data <- "data"

############################################################################
############################################################################
############################################################################
############################################################################


#Figure 4 Temporal distribution of A-C sections per session. Points represent participants per session.

file_name <- "datos-practica-uji.csv"
data_path <- here::here(folder_data, file_name)

intervention <- read_csv(data_path) %>%
  mutate(fecha_final = lubridate::dmy(fecha), 
         anyo = year(fecha_final)) %>%
  select(-fecha) %>%
  rename(num_sesion = id, dur_total = duracion, dur1 = duracion_1, dur2 = duracion_2, dur3 = duracion_3) %>%
  arrange(fecha_final)


intervention_session <- 
  intervention %>%
  select(-chicos, -chicas, -conocimiento, -cursos, -lugar) %>%
  select(num_sesion, fecha_final, anyo, everything())

intervention_session <- 
  intervention_session %>%
  gather(dur1, dur2, dur3, key = "tipo_seccion", value = "dur_seccion")

intervention_session <- 
  intervention_session %>%
  mutate (porcentaje = round(dur_seccion / dur_total, 2) * 100)

media_alumnos <- mean(intervention_session$alumnos) 

intervention_session <- 
  intervention_session %>%
  group_by(num_sesion)  %>%
  # mutate (pos = cumsum(porcentaje) - (0.5 * porcentaje)) %>%
  mutate (asistencia = ifelse(alumnos > media_alumnos, "mayor", "menor")) %>%
  arrange(desc(fecha_final), tipo_seccion)

intervention_session$asistencia <- 
  factor(intervention_session$asistencia, 
         level = unique(intervention_session$asistencia),
         labels = c("Upper average", "Lower average"))

# cols_asistencia <- c("Upper average" = "#a6611a", "Lower average" = "#dfc27d")
cols_asistencia <- c("Upper average" = "#7b3294", "Lower average" = "#008837")


intervention_session$tipo_seccion <- 
  factor(intervention_session$tipo_seccion, 
         level = unique(intervention_session$tipo_seccion),
         labels = c("A - Introductory talk", "B - Guided project", "C - Freestyle project"))


# http://t-redactyl.io/blog/2016/01/creating-plots-in-r-using-ggplot2-part-4-stacked-bar-plots.html
barplot <- 
  intervention_session %>%
  ggplot(aes(x=num_sesion, y=porcentaje)) + 
  geom_bar(aes(fill = tipo_seccion), stat = "identity", position= position_stack(reverse = TRUE)) +
  geom_point(aes(x=num_sesion, y=alumnos, colour=asistencia), alpha = 1/10, size=8) +
  scale_fill_brewer(palette = "Paired") +
  scale_colour_manual(values = cols_asistencia) +
  geom_text(aes(x=num_sesion, y=alumnos, label = alumnos), colour="black", size=4, vjust = 0, nudge_y = -0.5) +
  geom_text(aes(x=num_sesion, y=porcentaje, label = ifelse(porcentaje>0, paste0(porcentaje, "%"), "")),
            size=4, position = position_stack(vjust = 0.8)) +
  theme_classic() +
  theme(legend.position="bottom", 
        legend.direction="vertical",
        legend.title = element_blank()) +
  scale_y_continuous(labels = dollar_format(suffix = "%", prefix="")) +
  # geom_hline(yintercept=media_alumnos) +
  labs(x = "Course sessions (year - identifier)", y="Percentatge (%)") +
  theme(axis.text.x = element_text(angle = 60, vjust = 0.5, hjust=0.5))
# ggtitle("Ditribución temporal de secciones por sesión (%)")


file_name = "fig04.svg"
data_path <- here::here(folder_figs, file_name) # local file
svg(filename=data_path, width=13, height=6, pointsize=10)
barplot
dev.off()

file_name = "fig04.png"
data_path <- here::here(folder_figs, file_name) # local file
png(filename=data_path, width=850, height=480, units="px", pointsize=12)
barplot
dev.off()

############################################################################
############################################################################
############################################################################
############################################################################


#Figure 5 Results of the survey conducted in the 2019 edition of the 'Pràctica a l’UJI'. 
# Only high percentages (agree, totally agree) and neutral are shown. 
# All but one (2%) of the low percentages (strongly disagree, disagree) are zero.


file_name = "encuesta2019.xlsx"
data_path <- here::here(folder_data, file_name) 

likert_data_raw <-  
  read_excel(data_path,
    col_types = c("date", "numeric", "text", "numeric", "numeric","numeric","numeric","numeric"),
    na = c("NA",""))

likert_levels <- c(-2, -1, 0, 1, 2)
likert_labels <- c("Strognly disagree","Disagree","Neutral","Agree","Strongly agree")
turno_labels <- c("10-12h", "12-14h")
likert_data_raw[4:8] <- lapply(likert_data_raw[4:8], factor, levels=likert_levels, labels=likert_labels)
likert_data_raw$turno <- sapply(X = likert_data_raw$turno, FUN = function(x) {turno_labels[x]}) 

num_respondents <- nrow(likert_data_raw)

# Flag to generate long or short name for questions. 
short_names <- TRUE

likert_data_raw_df <- as.data.frame(select(likert_data_raw, c("fecha","turno","p1","p2","p3","p4","p5")))
if (short_names) {
  names(likert_data_raw_df) <- c("Fecha [Date]", 
                                 "Turno [Session]",
                                 "P1 [Q1]", 
                                 "P2 [Q2]",
                                 "P3 [Q3]",
                                 "P4 [Q4]",
                                 "P5 [Q5]")
} else {
  names(likert_data_raw_df) <- c("Fecha [Date]", 
                                 "Turno [Session]",
                                 "La clase me ha pasado volando [The class has flown by]", 
                                 "El caso práctica ha sido útil para entender los conceptos [The practical case has been useful to understand the concepts]",
                                 "La forma de organizar el trabajo en equipo me ha gustado [I liked the way of organizing teamwork]",
                                 "Me gustaría saber mas sobre sensores y programación [I would like to know more about sensors and programming]",
                                 "Ha sido fácil seguir el desarrollo del proyecto [It has been easy to follow the development of the project]")
}

likert_data_df <- likert(items=likert_data_raw_df[,c(3:7)])
#' If aggregated by "turno" or "session", see https://stackoverflow.com/questions/48340901/using-likert-package-in-r-for-analyzing-real-survey-data
# likert_data_df <- likert(items=likert_data_raw_df[,c(3:7)], grouping = factor(likert_data_raw_df$Fecha))

summary(likert_data_df)
       
title <- paste0("Survey 'Practica la UJI' 2019", ", N=", num_respondents)
plotlikert <- plot(likert_data_df, centered = FALSE, 
                   low.color = "goldenrod2", neutral.color = "grey90", high.color="indianred4",
                   plot.percent.low = FALSE, plot.percent.high = TRUE, plot.percent.neutral = TRUE,
                   wrap = 50, text.size = 4) + 
  ggtitle(title) + 
  theme(plot.title = element_text(hjust = 0.5)) + 
  guides(fill=guide_legend(title=c("Responses"), nrow = 1))
plotlikert

file_name = "fig05.svg"
data_path <- here::here(folder_figs, file_name) # local file
svg(filename=data_path, width=13, height=6, pointsize=10)
plotlikert
dev.off()

file_name = "fig05.png"
data_path <- here::here(folder_figs, file_name) # local file
png(filename=data_path, width=850, height=480, units="px", pointsize=12)
plotlikert
dev.off()
