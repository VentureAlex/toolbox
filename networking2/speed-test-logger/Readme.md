# Speedtest Logger
This Python script allows you to regularly measure and log your internet connection's download and upload speeds using the Speedtest.net service. The script creates a CSV file in a specified directory (`./speedtest-output` by default) and records the time of each speed test along with the measured download and upload speeds in megabits per second (Mbps).

## Requirements:
- Python 3.x
- `speedtest` library (install via `pip install speedtest-cli`)

## Usage:
1. Clone or download the repository.
2. Install the required `speedtest` library if not already installed: `pip install speedtest-cli`.
3. Run the script using Python: `python speedtest_logger.py`.
4. The script will continuously perform speed tests every 60 seconds and log the results to a CSV file (`speed_test.csv` by default) in the `speedtest-output` directory.

## Customize:
- You can customize the output directory by modifying the `directory` variable in the script.
- Adjust the sleep time (`time.sleep(60)`) to change the frequency of speed tests.

## Output:
The CSV file contains three columns:
- `time`: Timestamp of the speed test in HH:MM:SS format.
- `downspeed`: Download speed in Mbps.
- `upspeed`: Upload speed in Mbps.

## Notes:
- Ensure that Python and the `speedtest` library are properly installed and configured on your system.
- This script requires internet connectivity to perform speed tests.
- Feel free to modify and adapt the script to suit your specific requirements.