python3.8 setup.py bdist_wheel
python3.8 setup.py install bdist_wheel
python3.8 setup.py build
python3.8 setup.py install
python3.8 -m pip install dist/*.whl
python3.8 -m pip install build/*.whl
