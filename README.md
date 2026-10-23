# Mapex

**Mapex** is a Stata add-on for producing a choropleth map of a single variable across the provinces of Iran. It wraps selected functionality from Ben Jann's [`geoplot`](https://ideas.repec.org/c/boc/bocode/s459211.html) workflow in a guided, dialog-based routine, so users can create a province-level map without writing the underlying mapping commands themselves.

> **Status:** Mapex is an early release. The current workflow is intended for data already aggregated to the province level. The dialog option for raw, individual-level data is not implemented yet.

## Features

- Maps one numeric variable across Iran's provinces.
- Uses a bundled province layout and matching geographic data.
- Lets you choose the variable to map, map colors, label colors, and the number of legend classes.
- Supports automatic class breaks or user-specified break points.
- Uses `geoplot` and related Stata community-contributed packages behind the scenes.

## Requirements

- **Stata 17 or later** (the programs and dialogs declare version 17).
- An internet connection for installing the required community-contributed dependencies.
- The following packages:
  - <a href="https://ideas.repec.org/c/boc/bocode/s459211.html" target="_blank">geoplot</a>
  - <a href="https://ideas.repec.org/c/boc/bocode/s458444.html" target="_blank">palettes</a>
  - <a href="https://ideas.repec.org/c/boc/bocode/s458597.html" target="_blank">colrspace</a>
  - <a href="https://ideas.repec.org/c/boc/bocode/s455001.html" target="_blank">moremata</a>
  - <a href="https://ideas.repec.org/c/boc/bocode/s456876.html" target="_blank">reclink</a>
  - <a href="https://ideas.repec.org/c/boc/bocode/s458071.html" target="_blank">missings</a>

Mapex checks for these dependencies when you run it and displays installation hints if some are missing. You can install them from Stata, for example:

```stata
ssc install geoplot
ssc install palettes
ssc install colrspace
ssc install moremata
ssc install reclink
ssc install missings
```

If a package is already installed, Stata may tell you that it is already present; that is fine.

## Installation

Once the repository is published, install Mapex from Stata with:

```stata
net install mapex, from("https://raw.githubusercontent.com/alisoltanimirzayi/mapex/main/") replace
```


## Quick start

1. Prepare the dataset in excel.
2. Run:

   ```stata
   mapex
   ```

3. Mapex opens a guided workflow. Follow the prompts to import or prepare the data, then click the **Continue** link shown in the Results window when prompted.
4. Select the variable containing province names.
5. Choose **aggregated province-level data**. The raw-data option is not yet implemented.
6. In the map settings dialog:
   - Select the numeric variable to plot.
   - Choose the start and end colors for the map's color ramp.
   - Choose the colors used for province-name and numeric labels.
   - Choose automatic classing and the number of classes, or enter custom break points.
7. Confirm the dialog to draw the map.

The routine creates/replaces working geographic frames and a temporary dataset in Mapex's installation directory while preparing the map. Save or export the resulting graph from Stata using the usual graph commands or Graph window controls.

## Data expectations

The current workflow is designed for **one observation per province** and a province-name variable that can be matched to the Iranian province names in Mapex's bundled reference data. The variable to map should be numeric.

- Check that all 31 provinces are represented.
- Use one consistent spelling per province and remove extra spaces where possible.
- Ensure the province variable is selected correctly in the dialog.
- Ensure the selected map variable contains meaningful numeric values.
- If your data contain multiple rows per province, aggregate them to the province level before using Mapex.

Mapex attempts a fuzzy match between the province names in your data and its bundled province reference file. Fuzzy matching is a convenience, not a substitute for checking the names and the matches.

## Example input data

The following example contains one observation for each of Iran's 31 provinces and a numeric variable, `x`, to map. The values are illustrative.

| province | var_to_plot |
|---|---:|
| آذربایجان شرقی | 178 |
| آذربایجان غربی | 47 |
| اردبیل | 677 |
| اصفهان | 481 |
| البرز | 369 |
| ایلام | 400 |
| بوشهر | 780 |
| تهران | 840 |
| خراسان جنوبی | 195 |
| خراسان رضوی | 454 |
| خراسان شمالی | 163 |
| خوزستان | 300 |
| زنجان | 750 |
| سمنان | 517 |
| سیستان و بلوچستان | 477 |
| فارس | 471 |
| قزوین | 630 |
| قم | 120 |
| لرستان | 361 |
| مازندران | 991 |
| مرکزی | 385 |
| هرمزگان | 786 |
| همدان | 265 |
| چهارمحال و بختیاری | 567 |
| کردستان | 438 |
| کرمان | 418 |
| کرمانشاه | 72 |
| کهگیلویه و بویراحمد | 390 |
| گلستان | 581 |
| گیلان | 116 |
| یزد | 820 |

After creating or importing the data, run `mapex` and select `province` as the province-name variable and `var_to_plot` as the variable to map.

## Class breaks

Mapex offers two approaches to classifying values for the map:

- **Automatic:** choose the number of classes (from 2 to 15); `geoplot` determines the breaks.
- **Manual:** enter the break points separated by spaces, in ascending order. For example, `10 20 30 40` defines cut points; make sure the values are appropriate for your variable and check the resulting legend.

The precise interpretation of break points follows the underlying `geoplot` options used by Mapex.

## Troubleshooting

**Mapex says a dependency is missing**  
Install the package named in the message with `ssc install package_name`, then click the Continue link again.

**Some provinces are missing or the map does not draw**  
Check that your province variable is selected correctly, the dataset has no more than one row per province, and the names match the 31 provinces. Check for spelling variants, leading/trailing spaces, and duplicate province rows.

**The raw-data option displays a message that it is not available**  
This is expected in the current release. Aggregate the data to one row per province before running Mapex.

**The legend or labels do not look right**  
Try a different number of classes, specify custom cut points, or change the label colors. Inspect the values and missingness of the selected numeric variable before plotting.

## Acknowledgements

Mapex is a convenience wrapper around community-contributed Stata mapping tools, especially Ben Jann's `geoplot`. Please consult the documentation for `geoplot` and its dependencies for details about their options and licenses.

## Bug reports and contributions

Please report bugs, mismatched province names, or suggestions in the repository's **Issues** section:

`https://github.com/alisoltanimirzayi/mapex/issues`

Replace the placeholder URL after the GitHub repository has been created.
