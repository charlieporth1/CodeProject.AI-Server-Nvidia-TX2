python3.9 setup.py bdist_wheel
python3.9 setup.py install bdist_wheel
python3.9 setup.py build
python3.9 setup.py install
python3.9 -m pip install dist/*.whl
python3.9 -m pip install build/*.whl
