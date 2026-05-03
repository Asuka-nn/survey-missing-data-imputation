# generate_demo_data.R
# Generates synthetic survey data compatible with the imputation scripts.
# Run this if you don't have access to the original restricted dataset.

set.seed(42)
n <- 500  # number of respondents

# ── Helper: introduce MNAR missingness ─────────────────────────────────────
introduce_mnar <- function(df, mnar_rate = 0.15) {
  df_mnar <- df
  for (col in names(df_mnar)) {
    # MNAR: higher values more likely to be missing
    prob_missing <- ifelse(df_mnar[[col]] >= 4, mnar_rate * 2, mnar_rate / 2)
    missing_idx  <- runif(nrow(df_mnar)) < prob_missing
    df_mnar[[col]][missing_idx] <- NA
  }
  df_mnar
}

# ── Block 1: 8-item Likert scale (1–5) ─────────────────────────────────────
block1_vars <- paste0("item_", 1:8)
df_block1   <- as.data.frame(
  replicate(8, sample(1:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.2, 0.1)))
)
names(df_block1) <- block1_vars
df_block1_mnar   <- introduce_mnar(df_block1)

# ── Block 2: 12-item Likert scale (1–5) ────────────────────────────────────
block2_vars <- paste0("item_", 1:12)
df_block2   <- as.data.frame(
  replicate(12, sample(1:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.2, 0.1)))
)
names(df_block2) <- block2_vars
df_block2_mnar   <- introduce_mnar(df_block2)

# ── Block 3: 9-item Likert scale (1–5) ─────────────────────────────────────
block3_vars <- paste0("item_", 1:9)
df_block3   <- as.data.frame(
  replicate(9, sample(1:5, n, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.2, 0.1)))
)
names(df_block3) <- block3_vars
df_block3_mnar   <- introduce_mnar(df_block3)

# ── MICE-compatible versions (self / cross / cleaned) ───────────────────────
df_self_mnar  <- introduce_mnar(df_block1, mnar_rate = 0.20)
df_cross_mnar <- introduce_mnar(df_block1, mnar_rate = 0.12)
df_cleaned    <- df_block1  # complete-case baseline

# ── Write to data/ ───────────────────────────────────────────────────────────
dir.create("data/output", showWarnings = FALSE, recursive = TRUE)

write.csv(df_block1,      "data/df_block1.csv",      row.names = FALSE)
write.csv(df_block1_mnar, "data/df_block1_mnar.csv", row.names = FALSE)
write.csv(df_block2,      "data/df_block2.csv",      row.names = FALSE)
write.csv(df_block2_mnar, "data/df_block2_mnar.csv", row.names = FALSE)
write.csv(df_block3,      "data/df_block3.csv",      row.names = FALSE)
write.csv(df_block3_mnar, "data/df_block3_mnar.csv", row.names = FALSE)
write.csv(df_self_mnar,   "data/df_self_mnar.csv",   row.names = FALSE)
write.csv(df_cross_mnar,  "data/df_cross_mnar.csv",  row.names = FALSE)
write.csv(df_cleaned,     "data/df_cleaned.csv",     row.names = FALSE)

cat("Demo data written to data/\n")
