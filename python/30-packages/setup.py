from distutils.core import setup

setup(
    name='yo',
    version='0.1dev',
    packages=['yo',],
    license='Creative Commons Attribution-Noncommercial-Share Alike license',
    long_description='I say "yo", you say "yeah"',
    entry_points = {
        'console_scripts': ['yo=yo.main:main'],
    }
)