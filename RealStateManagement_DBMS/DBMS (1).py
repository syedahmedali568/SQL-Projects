import streamlit as st
import mysql.connector
import pandas as pd

# Database connection function
def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="ebaad03183811407@",
        database="project"
    )

# Execute query function
def execute_query(query, params=None):
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute(query, params)
        conn.commit()
        return "Operation successful"
    except mysql.connector.Error as err:
        return f"Error: {err}"
    finally:
        cursor.close()
        conn.close()

# Fetch query function
def fetch_query(query, params=None):
    conn = connect_db()
    cursor = conn.cursor()
    try:
        cursor.execute(query, params)
        records = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        return pd.DataFrame(records, columns=columns)
    except mysql.connector.Error as err:
        return f"Error: {err}"
    finally:
        cursor.close()
        conn.close()

# Main Streamlit app
st.title("Real Estate Management System")

# Dropdown for Owners
st.sidebar.subheader("Owner Operations")
owner_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Owner", "View Owners", "Update Owner", "Delete Owner"])

if owner_choice == "Add Owner":
    st.subheader("Add Owner")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Add Owner"):
        query = "INSERT INTO Owner (Name, ContactInfo, Email) VALUES (%s, %s, %s)"
        result = execute_query(query, (name, contact, email))
        st.success(result)

elif owner_choice == "View Owners":
    st.subheader("View Owners")
    query = "SELECT * FROM Owner"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif owner_choice == "Update Owner":
    st.subheader("Update Owner")
    owner_id = st.text_input("Owner ID")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Update Owner"):
        query = "UPDATE Owner SET Name=%s, ContactInfo=%s, Email=%s WHERE OwnerID=%s"
        result = execute_query(query, (name, contact, email, owner_id))
        st.success(result)

elif owner_choice == "Delete Owner":
    st.subheader("Delete Owner")
    owner_id = st.text_input("Owner ID")
    if st.button("Delete Owner"):
        query = "DELETE FROM Owner WHERE OwnerID=%s"
        result = execute_query(query, (owner_id,))
        st.success(result)

# Dropdown for Properties
st.sidebar.subheader("Property Operations")
property_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Property", "View Properties", "Update Property", "Delete Property"])

if property_choice == "Add Property":
    st.subheader("Add Property")
    address = st.text_input("Address")
    price = st.number_input("Price")
    location_id = st.number_input("Location ID")
    owner_id = st.number_input("Owner ID")
    if st.button("Add Property"):
        query = "INSERT INTO Property (Address, Price, LocationID, OwnerID) VALUES (%s, %s, %s, %s)"
        result = execute_query(query, (address, price, location_id, owner_id))
        st.success(result)

elif property_choice == "View Properties":
    st.subheader("View Properties")
    query = "SELECT * FROM Property"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif property_choice == "Update Property":
    st.subheader("Update Property")
    property_id = st.text_input("Property ID")
    address = st.text_input("Address")
    price = st.text_input("Price")
    location_id = st.text_input("Location ID")
    owner_id = st.text_input("Owner ID")
    if st.button("Update Property"):
        query = "UPDATE Property SET Address=%s, Price=%s, LocationID=%s, OwnerID=%s WHERE PropertyID=%s"
        result = execute_query(query, (address, price, location_id, owner_id, property_id))
        st.success(result)

elif property_choice == "Delete Property":
    st.subheader("Delete Property")
    property_id = st.text_input("Property ID")
    if st.button("Delete Property"):
        query = "DELETE FROM Property WHERE PropertyID=%s"
        result = execute_query(query, (property_id,))
        st.success(result)

# Dropdown for Agents
st.sidebar.subheader("Agent Operations")
agent_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Agent", "View Agents", "Update Agent", "Delete Agent"])

if agent_choice == "Add Agent":
    st.subheader("Add Agent")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Add Agent"):
        query = "INSERT INTO Agent (Name, ContactInfo, Email) VALUES (%s, %s, %s)"
        result = execute_query(query, (name, contact, email))
        st.success(result)

elif agent_choice == "View Agents":
    st.subheader("View Agents")
    query = "SELECT * FROM Agent"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif agent_choice == "Update Agent":
    st.subheader("Update Agent")
    agent_id = st.text_input("Agent ID")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Update Agent"):
        query = "UPDATE Agent SET Name=%s, ContactInfo=%s, Email=%s WHERE AgentID=%s"
        result = execute_query(query, (name, contact, email, agent_id))
        st.success(result)

elif agent_choice == "Delete Agent":
    st.subheader("Delete Agent")
    agent_id = st.text_input("Agent ID")
    if st.button("Delete Agent"):
        query = "DELETE FROM Agent WHERE AgentID=%s"
        result = execute_query(query, (agent_id,))
        st.success(result)

# Dropdown for Customers
st.sidebar.subheader("Customer Operations")
customer_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Customer", "View Customers", "Update Customer", "Delete Customer"])

if customer_choice == "Add Customer":
    st.subheader("Add Customer")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Add Customer"):
        query = "INSERT INTO Customer (Name, ContactInfo, Email) VALUES (%s, %s, %s)"
        result = execute_query(query, (name, contact, email))
        st.success(result)

elif customer_choice == "View Customers":
    st.subheader("View Customers")
    query = "SELECT * FROM Customer"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif customer_choice == "Update Customer":
    st.subheader("Update Customer")
    customer_id = st.text_input("Customer ID")
    name = st.text_input("Name")
    contact = st.text_input("Contact Info")
    email = st.text_input("Email")
    if st.button("Update Customer"):
        query = "UPDATE Customer SET Name=%s, ContactInfo=%s, Email=%s WHERE CustomerID=%s"
        result = execute_query(query, (name, contact, email, customer_id))
        st.success(result)

elif customer_choice == "Delete Customer":
    st.subheader("Delete Customer")
    customer_id = st.text_input("Customer ID")
    if st.button("Delete Customer"):
        query = "DELETE FROM Customer WHERE CustomerID=%s"
        result = execute_query(query, (customer_id,))
        st.success(result)

# Dropdown for Locations
st.sidebar.subheader("Location Operations")
location_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Location", "View Locations", "Update Location", "Delete Location"])

if location_choice == "Add Location":
    st.subheader("Add Location")
    city = st.text_input("City")
    state = st.text_input("State")
    zipcode = st.text_input("Zipcode")
    address = st.text_input("Address")
    if st.button("Add Location"):
        query = "INSERT INTO Location (city,state,zipcode,address) VALUES (%s,%s,%s,%s)"
        result = execute_query(query, (city,state,zipcode,address))
        st.success(result)

elif location_choice == "View Locations":
    st.subheader("View Locations")
    query = "SELECT * FROM Location"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif location_choice == "Update Location":
    st.subheader("Update Existing Location")
    location_id = st.number_input("Enter Location ID", min_value=1)
    address = st.text_input("New Address")
    city = st.text_input("New City")
    state = st.text_input("New State")
    zipcode = st.text_input("New ZipCode")
    if st.button("Update Location"):
        query = "UPDATE LOCATION SET Address=%s, City=%s, State=%s, ZipCode=%s WHERE LocationID=%s"
        result = execute_query(query, (address, city, state, zipcode, customer_id))
        st.success(result)



elif location_choice == "Delete Location":
    st.subheader("Delete Location")
    location_id = st.text_input("Location ID")
    if st.button("Delete Location"):
        query = "DELETE FROM Location WHERE LocationID=%s"
        result = execute_query(query, (location_id,))
        st.success(result)

# Dropdown for Transactions (example for another table)
st.sidebar.subheader("Transaction Operations")
transaction_choice = st.sidebar.selectbox("Choose an operation", ["Select an option", "Add Transaction", "View Transactions", "Update Transaction", "Delete Transaction"])

if transaction_choice == "Add Transaction":
    st.subheader("Add Transaction")
    property_id = st.text_input("Property ID")
    customer_id = st.text_input("Customer ID")
    #agent_id = st.text_input("Agent ID")
    transaction_date = st.date_input("Transaction Date")
    amount = st.text_input("Amount")
    if st.button("Add Transaction"):
        query = "INSERT INTO Transaction (PropertyID, CustomerID, TransactionDate, Amount) VALUES (%s, %s, %s, %s)"
        result = execute_query(query, (property_id, customer_id, transaction_date, amount))
        st.success(result)

elif transaction_choice == "View Transactions":
    st.subheader("View Transactions")
    query = "SELECT * FROM Transaction"
    df = fetch_query(query)
    if isinstance(df, str):
        st.error(df)
    else:
        st.dataframe(df)

elif transaction_choice == "Update Transaction":
    st.subheader("Update Transaction")
    transaction_id = st.text_input("Transaction ID")
    property_id = st.text_input("Property ID")
    customer_id = st.text_input("Customer ID")
    #agent_id = st.text_input("Agent ID")
    transaction_date = st.date_input("Transaction Date")
    amount = st.text_input("Amount")
    if st.button("Update Transaction"):
        query = "UPDATE Transaction SET PropertyID=%s, CustomerID=%s, TransactionDate=%s, Amount=%s WHERE TransactionID=%s"
        result = execute_query(query, (property_id, customer_id, transaction_date, amount, transaction_id))
        st.success(result)

elif transaction_choice == "Delete Transaction":
    st.subheader("Delete Transaction")
    transaction_id = st.text_input("Transaction ID")
    if st.button("Delete Transaction"):
        query = "DELETE FROM Transaction WHERE TransactionID=%s"
        result = execute_query(query, (transaction_id,))
        st.success(result)

