Now trying it with summary stats.
```{r plotprestbox2, echo=FALSE}

ourdata$targgend = as.factor(ourdata$d0_s1)
ourdata$time = as.factor(ourdata$t)
ourdata$valence = as.factor(ourdata$statval)

data_sum  <- ourdata %>%
  group_by(time, targgend) %>%
  summarize_each(
    funs(mean = mean(impr, na.rm = TRUE), sd = sd(impr, na.rm = TRUE)))
#summarise(impr = mean(impr), sd = sd(impr, na.rm=TRUE))
data_sum

pd <- position_dodge(0.1) # move them .05 to the left and right

p <- ggplot(
  data = data_sum,
  mapping = aes(
    x=time,
    y=impr,
    group=targgend
  )
) +
  geom_errorbar(aes(ymin=impr-se, ymax=impr+se), colour="black", width=.1, position=pd) +
  geom_line(aes(linetype=targgend)) +
  geom_point(aes(shape=targgend))

ggsave(plot = p, width = 8, height = 3, dpi = 300, filename = "gender-diffs-avg.pdf")

```
