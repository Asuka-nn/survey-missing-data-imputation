# Survey Imputation: MICE vs KNN

Comparing traditional missing data imputation methods on a 2024 U.S. presidential election survey dataset with MNAR (Missing Not At Random) missingness patterns.

**Conference:** 80th Annual AAPOR Conference, St. Louis, MO (May 2025)  
**Authors:** Yuchen Ding, Angelina Lu, Weiyushi Tian, Brady West

---

## What this project does

Survey datasets frequently contain missing responses. This project evaluates two traditional imputation approaches under MNAR conditions — a realistic and challenging missingness mechanism where the probability of a value being missing depends on the value itself.

**Methods compared:**

| Method | Implementation | Key parameter |
|--------|---------------|---------------|
| MICE (PMM) | `mice` R package | m=5 imputations, maxit=5 |
| KNN | `VIM::kNN` | k selected via accuracy grid search |

**Data conditions:**

- `self_mnar` — self-reported missingness pattern
- `cross_mnar` — cross-item missingness pattern  
- `cleaned` — complete-case baseline

---

## Key finding

KNN with optimally selected k achieved **95–96% imputation accuracy** on held-out missing cells across three survey question blocks. MICE (PMM) produced comparable distributional fidelity. Trade-offs between the two methods are context-dependent — see the full paper for details.

---

## Repository structure

```
survey-imputation/
├── R/
│   ├── 01_mice_imputation.Rmd   # MICE pipeline + visualization
│   └── 02_knn_imputation.Rmd    # KNN with optimal k selection
├── data/
│   └── generate_demo_data.R     # Synthetic data generator (run this first)
└── README.md
```

> **Data note:** Original survey data are not included (restricted access).
> Run `data/generate_demo_data.R` to generate a compatible synthetic dataset.

---

## How to run

```r
# Step 1: generate synthetic data
source("data/generate_demo_data.R")

# Step 2: open and knit either notebook in RStudio
# R/01_mice_imputation.Rmd
# R/02_knn_imputation.Rmd
```

**Dependencies:** `mice`, `VIM`, `caret`, `ggplot2`, `dplyr`

```r
install.packages(c("mice", "VIM", "caret", "ggplot2", "dplyr"))
```

---

## Related work

This analysis is part of a broader project comparing LLM-based and traditional imputation methods. The LLM comparison component is described in the AAPOR 2025 paper.
