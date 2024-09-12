# STAGE 1: Base setup and necessary dependencies installation
# Fetch an R image and use it as base
FROM rocker/r-base:4.4.0 AS base

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libssl-dev

# Install project-dependent packages
RUN R -e "install.packages(c('plotly', 'corrgram'))"

# STAGE 2: Build the environment and install project
FROM base as builder

# Set the working directory
WORKDIR /home/R_explanatory_analysis

# Copy 'src' folder
COPY src ./src

# Run setup.R to install project-dependent packages
RUN Rscript ./src/setup.R


# STAGE 3: Final image with a leaner setup
FROM base AS final

# Set the working directory
WORKDIR /home/R_explanatory_analysis

# Copy renv.lock and src from builder stage
COPY --from=builder renv.lock ./renv.lock
COPY --from=builder src ./src

# Restore the environment
RUN Rscript -e "renv::restore(lockfile = 'renv.lock')"

# Run the application
CMD ["Rscript", "./src/main.R"]
