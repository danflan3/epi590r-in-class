library(tidyverse)
library(gtsummary)

nlsy_cols <- c("glasses", "eyesight", "sleep_wkdy", "sleep_wknd",
							 "id", "nsibs", "samp", "race_eth", "sex", "region",
							 "income", "res_1980", "res_2002", "age_bir")
nlsy <- read_csv(here::here("data", "raw", "nlsy.csv"),
								 na = c("-1", "-2", "-3", "-4", "-5", "-998"),
								 skip = 1, col_names = nlsy_cols) |>
	mutate(region_cat = factor(region, labels = c("Northeast", "North Central", "South", "West")),
				 sex_cat = factor(sex, labels = c("Male", "Female")),
				 race_eth_cat = factor(race_eth, labels = c("Hispanic", "Black", "Non-Black, Non-Hispanic")),
				 eyesight_cat = factor(eyesight, labels = c("Excellent", "Very good", "Good", "Fair", "Poor")),
				 glasses_cat = factor(glasses, labels = c("No", "Yes")))


# Customization of `tbl_summary()` examples

##First Table Summary -- row section headers display raw variable name
tbl_summary(
	nlsy,
	by = sex_cat,
	include = c(sex_cat, race_eth_cat, region_cat,
							eyesight_cat, glasses, age_bir))

##Second Table Summary -- row headings relabeled to mask variable names
tbl_summary(
	nlsy,
	by = sex_cat,
	include = c(sex_cat, race_eth_cat, region_cat,
							eyesight_cat, glasses, age_bir),
	label = list(
		race_eth_cat ~ "Race/ethnicity",
		region_cat ~ "Region",
		eyesight_cat ~ "Eyesight",
		glasses ~ "Wears glasses",
		age_bir ~ "Age at first birth"
	),
	missing_text = "Missing")

#Third Table Summary -- bold headers, add p-values
tbl_summary(
	nlsy,
	by = sex_cat,
	include = c(sex_cat, race_eth_cat,
							eyesight_cat, glasses, age_bir),
	label = list(
		race_eth_cat ~ "Race/ethnicity",
		eyesight_cat ~ "Eyesight",
		glasses ~ "Wears glasses",
		age_bir ~ "Age at first birth"
	),
	missing_text = "Missing") |>
	add_p(test = list(all_continuous() ~ "t.test",
										all_categorical() ~ "chisq.test")) |>
	add_overall(col_label = "**Total**") |>
	bold_labels() |>
	modify_footnote(update = everything() ~ NA) |>
	modify_header(label = "**Variable**", p.value = "**P**")


### IN CLASS EXERCISE (3-7) ###
## (3) Make tbl_summary that includes region, race/ethnicity, income, and sleep variables. Label variable names.
tbl_summary(
	nlsy,
	include = c(region_cat, race_eth_cat, income, sleep_wkdy, sleep_wknd),
	label = list(
		region_cat ~ "Region",
		race_eth_cat ~ "Race/ethnicity",
		income ~ "Income",
		sleep_wkdy ~ "Hours of Sleep - Weekday",
		sleep_wknd ~ "Hours of Sleep - Weekend"
	),
	missing_text = "Missing",) |>
	bold_labels()

## Select variables using helper function!
tbl_summary(
	nlsy,
	include = c(region_cat, race_eth_cat, income, starts_with("sleep_")),
	label = list(
		region_cat ~ "Region",
		race_eth_cat ~ "Race/ethnicity",
		income ~ "Income",
		sleep_wkdy ~ "Hours of Sleep - Weekday",
		sleep_wknd ~ "Hours of Sleep - Weekend"
	),
	missing_text = "Missing",) |>
	bold_labels()



## (4) Stratify table by sex. Add p-value comparing the sexes. Add overall column combining both sexes.
tbl_summary(
		nlsy,
		by = sex_cat,
		include = c(region_cat, race_eth_cat, income, sleep_wkdy, sleep_wknd),
		label = list(
			region_cat ~ "Region",
			race_eth_cat ~ "Race/ethnicity",
			income ~ "Income",
			sleep_wkdy ~ "Hours of Sleep - Weekday",
			sleep_wknd ~ "Hours of Sleep - Weekend"
		),
		missing_text = "Missing") |>
		bold_labels() |>
				add_p(test = list(all_continuous() ~ "t.test",
													all_categorical() ~ "chisq.test")) |>
				add_overall(col_label = "**Total**")



## (5) For income variable, show 10th and 90th percentiles of income with 3 digits.
##			For sleep variables, show min/max with 1 digit
tbl_summary(
		nlsy,
		by = sex_cat,
		include = c(region_cat, race_eth_cat, income, sleep_wkdy, sleep_wknd),
		label = list(
			region_cat ~ "Region",
			race_eth_cat ~ "Race/ethnicity",
			income ~ "Income",
			sleep_wkdy ~ "Hours of Sleep - Weekday",
			sleep_wknd ~ "Hours of Sleep - Weekend"
		),
				statistic = list(
					income ~ "({p10},{p90})",
					starts_with("sleep_") ~ "min={min}; max={max}"
				),
				digit = list(
					income ~ c(3,3),
					starts_with("sleep_") ~ c(1,1)
				),
		missing_text = "Missing") |>
		add_p(test = list(all_continuous() ~ "t.test",
											all_categorical() ~ "chisq.test")) |>
		add_overall(col_label = "**Total**")



## (6) Add footnote to race/ethnicity with a link to the page describing how NLSY classified participants:
##			https://www.nlsinfo.org/content/cohorts/nlsy79/topical-guide/household/race-ethnicity-immigration-data

tbl_summary(
		nlsy,
		by = sex_cat,
		include = c(region_cat, race_eth_cat, income, sleep_wkdy, sleep_wknd),
		label = list(
			region_cat ~ "Region",
			race_eth_cat ~ "Race/ethnicity",
			income ~ "Income",
			sleep_wkdy ~ "Hours of Sleep - Weekday",
			sleep_wknd ~ "Hours of Sleep - Weekend"
		),
		statistic = list(
			income ~ "({p10},{p90})",
			starts_with("sleep_") ~ "min={min}; max={max}"
		),
		digit = list(
			income ~ c(3,3),
			starts_with("sleep_") ~ c(1,1)
		),
		missing_text = "Missing") |>
		bold_labels() |>
		add_p(test = list(all_continuous() ~ "t.test",
											all_categorical() ~ "chisq.test")) |>
		add_overall(col_label = "**Total**") |>
				modify_table_styling(
					columns = label,
					rows = label == "Race/ethnicity",
					footnote = "https://www.nlsinfo.org/content/cohorts/nlsy79/topical-guide/household/race-ethnicity-immigration-data"
				)


## Answers will be posted to Louisa's github class repository











