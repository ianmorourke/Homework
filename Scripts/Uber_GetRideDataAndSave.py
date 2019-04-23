from uber_rides.session import Session
from uber_rides.client import UberRidesClient
import pyodbc

session = Session(server_token="fbY2FdDixlrNaKFU3naVqcjOv1Dxx5pfR7DEJ-jp")
client = UberRidesClient(session)

response = client.get_products(40.332, -80.122)
products = response.json.get('products')

#print(products)
#print(products[1]['price_details']['cost_per_minute'])

server = 'DESKTOP-E0D8SBC'
database = 'ubermockup'
username = 'UberBasicUser'
password = 'U83r7357U53r#1m0!'

conn = pyodbc.connect(
    r'DRIVER={SQL Server};'
    r'SERVER='+server+';'
    r'DATABASE'+database+';'
    r'UID='+username+';'
    r'PWD='+password
)
cursor = conn.cursor()

cursor.execute("insert into ubermockup.dbo.pythonSampleProductsLog(productID, costPerMinute, Created)values (?, ?, GETDATE())", products[1]['product_id'], products[1]['price_details']['cost_per_minute'])
conn.commit()