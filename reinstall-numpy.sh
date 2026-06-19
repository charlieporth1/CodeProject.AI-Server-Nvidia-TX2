python3.8 -m pip uninstall numpy -y

# Install numpy from source, disabling pre-built wheels
python3.8 -m pip install --no-binary :all: numpy==1.19.5

python3.9 -m pip uninstall numpy -y

# Install numpy from source, disabling pre-built wheels
python3.9 -m pip install --no-binary :all: numpy==1.19.5
