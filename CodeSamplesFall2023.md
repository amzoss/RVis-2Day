<style>
a {
font-weight: 500;
}
</style>

# Extra code samples from the Fall 2023 class

## Day 1

### Exercise 2

This code shows how to include information about data completeness in chart labels.

```
complete_cases <- inclusiveness_index %>% complete.cases(.) %>% sum()

labels <- labs(
  title="Short Title",
  x="Z-score for Religion",
  y="Inclusiveness Index",
  alt="Scatterplot of inclusiveness index data for countries in five continents, 
  showing a weak positive correlation between Religion Z-score and index.",
  caption=paste0("There were ", complete_cases, " complete rows in the dataset.")
) 

color_scatter +
  labels
```

Example of adding multiple reference lines, including a reference line based
on a calculation.

```
color_scatter +
  geom_hline(mapping=aes(yintercept = mean(Inclusiveness.index.2020, na.rm=T))) +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = 0)
```

Adding a text annotation.

```
annotate(“text”, x=14.5, y=3.8, label=“median”, size=8)
```


### Exercise 3

Filter a data frame in a secondary shape layer.

```
ggplot(data=got, mapping=aes(x=moral, y=physical, label=label, color=gender))+
  geom_point(alpha=.75) +
  geom_text(data=got %>% filter(loyalty=="Stark"), nudge_y=.035, show.legend = F)
```

## Day 2

### Exercise 2

We realized the circle size doesn't scale, just like text size doesn't scale. Here
is how to change the size limits of the circle sizes.

```
+ scale_size_continuous(range = c(1, 18))
```

### Exercise 4

This isn't specific to plotly, but here is a sample of adding error bars to plots.

```
incl_error <- inclusiveness_index %>%
  drop_na(Inclusiveness.index.2020) %>%
  group_by(Continent) %>%
  summarise(avg_inclusiveness = mean(Inclusiveness.index.2020),
            min_inclusiveness = min(Inclusiveness.index.2020),
            max_inclusiveness = max(Inclusiveness.index.2020))

incl_error

ggplot(data = incl_error) +
  geom_point(aes(x=Continent, y=avg_inclusiveness)) +
  geom_errorbar(aes(x=Continent, ymin=min_inclusiveness, ymax=max_inclusiveness), width=.2) +
  geom_hline(yintercept = 0) +
  coord_flip() +
  annotate("text", y=-.75, x=5, label="some text.")
```
