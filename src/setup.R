# Initialize renv
if (!file.exists("renv.lock")) {
  renv::init()
}

# Snapshot the environment
renv::snapshot()
