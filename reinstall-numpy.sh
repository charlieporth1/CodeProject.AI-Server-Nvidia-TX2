# python3.8 -m pip uninstall numpy -y
# python3.8 -m pip install numpy==1.19.5

# python3.9 -m pip uninstall numpy -y
# python3.9 -m pip install  numpy==1.19.5


. /app/runtimes/bin/ubuntu/python38/venv/bin/activate
python3.8 -m pip uninstall numpy -y

# Install numpy from source, disabling pre-built wheels
# python3.8 -m pip install --no-binary :all: numpy==1.19.5
python3.8 -m pip install numpy==1.19.5

. /app/runtimes/bin/ubuntu/python39/venv/bin/activate
python3.9 -m pip uninstall numpy -y

# Install numpy from source, disabling pre-built wheels
#python3.9 -m pip install --no-binary :all: numpy==1.19.5
python3.9 -m pip install  numpy==1.19.5
