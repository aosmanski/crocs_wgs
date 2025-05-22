# Load required library
library(segmented)

# Enhanced broken stick (segmented regression) analysis
analyze_broken_stick <- function(retic, ic, criterion_name = "AIC") {
  cat(paste("\n", criterion_name, "Broken Stick (Segmented Regression) Analysis:\n"))
  
  # Create data frame
  df <- data.frame(x = retic, y = ic)
  
  # Fit initial linear model
  lm_fit <- lm(y ~ x, data = df)
  
  cat(paste("Initial linear model R²:", round(summary(lm_fit)$r.squared, 4), "\n"))
  cat(paste("Initial linear slope:", round(coef(lm_fit)[2], 4), "\n"))
  
  # Try to fit segmented regression
  tryCatch({
    # Try segmented regression with automatic breakpoint detection
    seg_fit <- segmented(lm_fit, seg.Z = ~x, npsi = 1)  # npsi = 1 means one breakpoint
    
    # Extract breakpoint
    breakpoint <- seg_fit$psi[1, "Est."]
    breakpoint_se <- seg_fit$psi[1, "St.Err"]
    breakpoint_rounded <- round(breakpoint)
    
    cat(paste("Breakpoint detected at:", round(breakpoint, 3), "±", round(breakpoint_se, 3), "\n"))
    cat(paste("Rounded breakpoint:", breakpoint_rounded, "reticulations\n"))
    
    # Get slopes before and after breakpoint
    slopes <- slope(seg_fit, conf.level = 0.95)
    slope_before <- slopes$x[1, "Est."]
    slope_after <- slopes$x[2, "Est."]
    
    cat(paste("Slope before breakpoint:", round(slope_before, 4), criterion_name, "units per reticulation\n"))
    cat(paste("Slope after breakpoint:", round(slope_after, 4), criterion_name, "units per reticulation\n"))
    cat(paste("Change in slope:", round(slope_after - slope_before, 4), "\n"))
    
    # Model fit statistics
    seg_r_squared <- summary(seg_fit)$r.squared
    davies_test <- davies.test(lm_fit, seg.Z = ~x)
    
    cat(paste("Segmented model R²:", round(seg_r_squared, 4), "\n"))
    cat(paste("Improvement in R² over linear:", round(seg_r_squared - summary(lm_fit)$r.squared, 4), "\n"))
    cat(paste("Davies test p-value:", round(davies_test$p.value, 6), 
              if(davies_test$p.value < 0.05) " (significant breakpoint)" else " (non-significant breakpoint)", "\n"))
    
    # Calculate fitted values and residuals
    fitted_vals <- fitted(seg_fit)
    residuals <- residuals(seg_fit)
    
    # Show values around breakpoint
    cat(paste("\nValues around breakpoint:\n"))
    breakpoint_idx <- which.min(abs(retic - breakpoint))
    context_range <- max(1, breakpoint_idx-2):min(length(retic), breakpoint_idx+2)
    
    for(i in context_range) {
      marker <- if(abs(retic[i] - breakpoint) < 0.5) " <- NEAR BREAKPOINT" else ""
      cat(paste("  Reticulations:", retic[i], 
                " - Observed", criterion_name, ":", round(ic[i], 2),
                " - Fitted:", round(fitted_vals[i], 2),
                " - Residual:", round(residuals[i], 2), marker, "\n"))
    }
    
    # Interpretation
    cat(paste("\nInterpretation:\n"))
    if(davies_test$p.value < 0.05) {
      if(abs(slope_after) < abs(slope_before)) {
        cat(paste("  ✓ Significant breakpoint detected at ~", breakpoint_rounded, "reticulations\n"))
        cat(paste("  ✓ Rate of improvement decreases substantially after this point\n"))
        cat(paste("  ✓ This suggests", breakpoint_rounded, "reticulations is optimal\n"))
      } else {
        cat(paste("  ⚠ Significant breakpoint detected, but slope doesn't decrease as expected\n"))
        cat(paste("  ⚠ Consider examining data more closely\n"))
      }
    } else {
      cat(paste("  ⚠ No significant breakpoint detected\n"))
      cat(paste("  ⚠ Relationship may be approximately linear\n"))
      cat(paste("  ⚠ Consider using other methods for optimal selection\n"))
    }
    
    cat(paste("Recommended optimal reticulations (broken stick):", breakpoint_rounded, "\n"))
    
    return(list(
      optimal = breakpoint_rounded,
      breakpoint = breakpoint,
      breakpoint_se = breakpoint_se,
      slope_before = slope_before,
      slope_after = slope_after,
      r_squared = seg_r_squared,
      davies_p = davies_test$p.value,
      fitted_values = fitted_vals,
      model = seg_fit
    ))
    
  }, error = function(e) {
    cat(paste("Error fitting segmented regression:", e$message, "\n"))
    cat(paste("This might indicate:\n"))
    cat(paste("  - No clear breakpoint exists in the data\n"))
    cat(paste("  - Relationship is approximately linear\n"))
    cat(paste("  - Need more data points\n"))
    cat(paste("  - Try other methods for optimal selection\n"))
    
    # Fallback to minimum value
    optimal_fallback <- retic[which.min(ic)]
    cat(paste("Using fallback method - minimum", criterion_name, "at:", optimal_fallback, "reticulations\n"))
    
    return(list(
      optimal = optimal_fallback,
      error = e$message,
      breakpoint = NA
    ))
  })
}

# Run the broken stick analysis
broken_stick_aic <- analyze_broken_stick(mean_aic$RETIC, mean_aic$AIC, "AIC")
broken_stick_bic <- analyze_broken_stick(mean_bic$RETIC, mean_bic$BIC, "BIC")

# Extract optimal values
optimal_aic_broken_stick <- broken_stick_aic$optimal
optimal_bic_broken_stick <- broken_stick_bic$optimal

cat(paste("\nSUMMARY:\n"))
cat(paste("Optimal AIC reticulations (broken stick):", optimal_aic_broken_stick, "\n"))
cat(paste("Optimal BIC reticulations (broken stick):", optimal_bic_broken_stick, "\n"))
