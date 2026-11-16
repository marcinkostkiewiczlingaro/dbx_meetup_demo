# Databricks notebook source
# MAGIC %md
# MAGIC # Metric Views for the Gold Star Schema (TPC-DS Sample Data)
# MAGIC
# MAGIC The following metric views are defined in the `workspace.gold` schema, sourcing the gold `fct_*` fact and `dim_*` dimension tables instead of the raw bronze tables. They adopt the bronze metric definitions; measures and dimensions that gold does not carry are dropped (see notes below).
# MAGIC
# MAGIC | Metric View Name         | Gold Source Table    | Category/type        |
# MAGIC |-------------------------|----------------------|----------------------|
# MAGIC | store_sales_metrics     | fct_store_sales      | Transaction          |
# MAGIC | web_sales_metrics       | fct_web_sales        | Transaction          |
# MAGIC | catalog_sales_metrics   | fct_catalog_sales    | Transaction          |
# MAGIC | store_returns_metrics   | fct_store_returns    | Returns              |
# MAGIC | web_returns_metrics     | fct_web_returns      | Returns              |
# MAGIC | catalog_returns_metrics | fct_catalog_returns  | Returns              |
# MAGIC | inventory_metrics       | fct_inventory        | Stock/Fact           |
# MAGIC | item_metrics            | dim_item             | Dimension            |
# MAGIC | promotion_metrics       | dim_promotion        | Dimension            |
# MAGIC | store_metrics           | dim_store            | Dimension            |
# MAGIC | customer_metrics        | dim_customer         | Entity               |
# MAGIC
# MAGIC Notes on the gold adoption:
# MAGIC * Sales facts carry `quantity`, `list_price`, `sales_price`, `wholesale_cost`, `sales_amount`, `discount_amount`, `net_paid`, `net_profit`. Bronze-only measures (Extended Wholesale Cost, Extended List Price, Extended Tax, Coupon Amount, Net Paid Including Tax) are not carried by gold and are dropped.
# MAGIC * Return facts carry only `return_quantity`, `return_amount`, `return_tax`, `return_fee`, `net_loss`. Refunded Cash, Store/Account Credit, Amount Including Tax, Return Ship Cost, and Reversed Charge are not carried by gold and are dropped. The return-reason dimension is also not carried on gold return facts.
# MAGIC * `gold.dim_customer` has no demographics/household keys, so Gender, Marital Status, Education, and Buy Potential dimensions cannot be reproduced; city/state/country are available on the dimension itself.
# MAGIC * Dimensions now use natural keys and descriptive attributes from the gold dims (e.g. `store_id`, `store_name`, `brand`, `promo_name`) instead of bronze surrogate keys.
# MAGIC
# MAGIC These metric views are reusable and can be combined for advanced reporting or analysis.

# COMMAND ----------

# DBTITLE 1,store_sales_metrics
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.store_sales_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_store_sales
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: store
# MAGIC     source: workspace.gold.dim_store
# MAGIC     on: source.store_key = store.store_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: promotion
# MAGIC     source: workspace.gold.dim_promotion
# MAGIC     on: source.promo_key = promotion.promo_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Store ID
# MAGIC     expr: store.store_id
# MAGIC   - name: Store Name
# MAGIC     expr: store.store_name
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Category
# MAGIC     expr: item.category
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Promotion Name
# MAGIC     expr: promotion.promo_name
# MAGIC   - name: Sold Date
# MAGIC     expr: sold_date
# MAGIC   - name: Ticket Number
# MAGIC     expr: ticket_number
# MAGIC measures:
# MAGIC   - name: Sales Quantity
# MAGIC     expr: SUM(quantity)
# MAGIC   - name: Gross Sales
# MAGIC     expr: SUM(sales_price * quantity)
# MAGIC   - name: Net Paid
# MAGIC     expr: SUM(net_paid)
# MAGIC   - name: Net Profit
# MAGIC     expr: SUM(net_profit)
# MAGIC   - name: Wholesale Cost
# MAGIC     expr: SUM(wholesale_cost)
# MAGIC   - name: List Price
# MAGIC     expr: SUM(list_price)
# MAGIC   - name: Extended Discount Amount
# MAGIC     expr: SUM(discount_amount)
# MAGIC   - name: Extended Sales Price
# MAGIC     expr: SUM(sales_amount)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,customer_metrics
# MAGIC %sql
# MAGIC -- Gold dim_customer carries no demographics/household keys, so those
# MAGIC -- dimensions cannot be adopted; city/state/country live on the dimension itself.
# MAGIC CREATE OR REPLACE VIEW workspace.gold.customer_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.dim_customer
# MAGIC dimensions:
# MAGIC   - name: Customer Key
# MAGIC     expr: customer_key
# MAGIC   - name: Customer ID
# MAGIC     expr: customer_id
# MAGIC   - name: Preferred Customer
# MAGIC     expr: is_preferred_customer
# MAGIC   - name: City
# MAGIC     expr: customer_city
# MAGIC   - name: State
# MAGIC     expr: customer_state
# MAGIC   - name: Country
# MAGIC     expr: customer_country
# MAGIC measures:
# MAGIC   - name: Customer Count
# MAGIC     expr: COUNT(customer_key)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Catalog sales metrics metric view
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.catalog_sales_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_catalog_sales
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: promotion
# MAGIC     source: workspace.gold.dim_promotion
# MAGIC     on: source.promo_key = promotion.promo_key
# MAGIC   - name: call_center
# MAGIC     source: workspace.gold.dim_call_center
# MAGIC     on: source.call_center_key = call_center.call_center_key
# MAGIC   - name: catalog_page
# MAGIC     source: workspace.gold.dim_catalog_page
# MAGIC     on: source.catalog_page_key = catalog_page.catalog_page_key
# MAGIC   - name: ship_mode
# MAGIC     source: workspace.gold.dim_ship_mode
# MAGIC     on: source.ship_mode_key = ship_mode.ship_mode_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Promotion Name
# MAGIC     expr: promotion.promo_name
# MAGIC   - name: Call Center
# MAGIC     expr: call_center.call_center_id
# MAGIC   - name: Catalog Page
# MAGIC     expr: catalog_page.catalog_page_id
# MAGIC   - name: Ship Mode
# MAGIC     expr: ship_mode.ship_mode_type
# MAGIC   - name: Sold Date
# MAGIC     expr: sold_date
# MAGIC   - name: Order Number
# MAGIC     expr: order_number
# MAGIC measures:
# MAGIC   - name: Sales Quantity
# MAGIC     expr: SUM(quantity)
# MAGIC   - name: Gross Sales
# MAGIC     expr: SUM(sales_price * quantity)
# MAGIC   - name: Net Paid
# MAGIC     expr: SUM(net_paid)
# MAGIC   - name: Net Profit
# MAGIC     expr: SUM(net_profit)
# MAGIC   - name: Wholesale Cost
# MAGIC     expr: SUM(wholesale_cost)
# MAGIC   - name: List Price
# MAGIC     expr: SUM(list_price)
# MAGIC   - name: Extended Discount Amount
# MAGIC     expr: SUM(discount_amount)
# MAGIC   - name: Extended Sales Price
# MAGIC     expr: SUM(sales_amount)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Web sales metrics metric view
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.web_sales_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_web_sales
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: promotion
# MAGIC     source: workspace.gold.dim_promotion
# MAGIC     on: source.promo_key = promotion.promo_key
# MAGIC   - name: web_site
# MAGIC     source: workspace.gold.dim_web_site
# MAGIC     on: source.web_site_key = web_site.web_site_key
# MAGIC   - name: web_page
# MAGIC     source: workspace.gold.dim_web_page
# MAGIC     on: source.web_page_key = web_page.web_page_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Promotion Name
# MAGIC     expr: promotion.promo_name
# MAGIC   - name: Web Site
# MAGIC     expr: web_site.web_site_name
# MAGIC   - name: Web Page
# MAGIC     expr: web_page.web_page_id
# MAGIC   - name: Sold Date
# MAGIC     expr: sold_date
# MAGIC   - name: Order Number
# MAGIC     expr: order_number
# MAGIC measures:
# MAGIC   - name: Sales Quantity
# MAGIC     expr: SUM(quantity)
# MAGIC   - name: Gross Sales
# MAGIC     expr: SUM(sales_price * quantity)
# MAGIC   - name: Net Paid
# MAGIC     expr: SUM(net_paid)
# MAGIC   - name: Net Profit
# MAGIC     expr: SUM(net_profit)
# MAGIC   - name: Wholesale Cost
# MAGIC     expr: SUM(wholesale_cost)
# MAGIC   - name: List Price
# MAGIC     expr: SUM(list_price)
# MAGIC   - name: Extended Discount Amount
# MAGIC     expr: SUM(discount_amount)
# MAGIC   - name: Extended Sales Price
# MAGIC     expr: SUM(sales_amount)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Store returns metrics metric view
# MAGIC %sql
# MAGIC -- Gold fct_store_returns carries no reason key and no refunded-cash/store-credit/
# MAGIC -- ship-cost/reversed-charge columns; those bronze measures are dropped.
# MAGIC CREATE OR REPLACE VIEW workspace.gold.store_returns_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_store_returns
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: store
# MAGIC     source: workspace.gold.dim_store
# MAGIC     on: source.store_key = store.store_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Store ID
# MAGIC     expr: store.store_id
# MAGIC   - name: Store Name
# MAGIC     expr: store.store_name
# MAGIC   - name: Return Date
# MAGIC     expr: returned_date
# MAGIC   - name: Ticket Number
# MAGIC     expr: ticket_number
# MAGIC measures:
# MAGIC   - name: Returned Quantity
# MAGIC     expr: SUM(return_quantity)
# MAGIC   - name: Return Amount
# MAGIC     expr: SUM(return_amount)
# MAGIC   - name: Net Loss
# MAGIC     expr: SUM(net_loss)
# MAGIC   - name: Fee
# MAGIC     expr: SUM(return_fee)
# MAGIC   - name: Return Tax
# MAGIC     expr: SUM(return_tax)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Web returns metrics metric view definition
# MAGIC %sql
# MAGIC -- Gold fct_web_returns collapses refunded/returning customer into one customer_key
# MAGIC -- and carries no reason, cash, credit, ship-cost, or reversed-charge columns.
# MAGIC CREATE OR REPLACE VIEW workspace.gold.web_returns_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_web_returns
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: web_page
# MAGIC     source: workspace.gold.dim_web_page
# MAGIC     on: source.web_page_key = web_page.web_page_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Web Page ID
# MAGIC     expr: web_page.web_page_id
# MAGIC   - name: Return Date
# MAGIC     expr: returned_date
# MAGIC   - name: Order Number
# MAGIC     expr: order_number
# MAGIC measures:
# MAGIC   - name: Return Quantity
# MAGIC     expr: SUM(return_quantity)
# MAGIC   - name: Return Amount
# MAGIC     expr: SUM(return_amount)
# MAGIC   - name: Net Loss
# MAGIC     expr: SUM(net_loss)
# MAGIC   - name: Fee
# MAGIC     expr: SUM(return_fee)
# MAGIC   - name: Return Tax
# MAGIC     expr: SUM(return_tax)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Catalog returns metrics metric view definition
# MAGIC %sql
# MAGIC -- Gold fct_catalog_returns collapses refunded/returning customer into one
# MAGIC -- customer_key and carries no reason, warehouse, cash, credit, ship-cost, or
# MAGIC -- reversed-charge columns.
# MAGIC CREATE OR REPLACE VIEW workspace.gold.catalog_returns_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_catalog_returns
# MAGIC joins:
# MAGIC   - name: customer
# MAGIC     source: workspace.gold.dim_customer
# MAGIC     on: source.customer_key = customer.customer_key
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: call_center
# MAGIC     source: workspace.gold.dim_call_center
# MAGIC     on: source.call_center_key = call_center.call_center_key
# MAGIC   - name: catalog_page
# MAGIC     source: workspace.gold.dim_catalog_page
# MAGIC     on: source.catalog_page_key = catalog_page.catalog_page_key
# MAGIC   - name: ship_mode
# MAGIC     source: workspace.gold.dim_ship_mode
# MAGIC     on: source.ship_mode_key = ship_mode.ship_mode_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Customer ID
# MAGIC     expr: customer.customer_id
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Call Center
# MAGIC     expr: call_center.call_center_id
# MAGIC   - name: Catalog Page
# MAGIC     expr: catalog_page.catalog_page_id
# MAGIC   - name: Ship Mode
# MAGIC     expr: ship_mode.ship_mode_type
# MAGIC   - name: Return Date
# MAGIC     expr: returned_date
# MAGIC   - name: Order Number
# MAGIC     expr: order_number
# MAGIC measures:
# MAGIC   - name: Return Quantity
# MAGIC     expr: SUM(return_quantity)
# MAGIC   - name: Return Amount
# MAGIC     expr: SUM(return_amount)
# MAGIC   - name: Net Loss
# MAGIC     expr: SUM(net_loss)
# MAGIC   - name: Fee
# MAGIC     expr: SUM(return_fee)
# MAGIC   - name: Return Tax
# MAGIC     expr: SUM(return_tax)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Inventory metrics metric view definition
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.inventory_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.fct_inventory
# MAGIC joins:
# MAGIC   - name: item
# MAGIC     source: workspace.gold.dim_item
# MAGIC     on: source.item_key = item.item_key
# MAGIC   - name: warehouse
# MAGIC     source: workspace.gold.dim_warehouse
# MAGIC     on: source.warehouse_key = warehouse.warehouse_key
# MAGIC   - name: date_dim
# MAGIC     source: workspace.gold.dim_date
# MAGIC     on: source.date_key = date_dim.date_key
# MAGIC dimensions:
# MAGIC   - name: Item ID
# MAGIC     expr: item.item_id
# MAGIC   - name: Brand
# MAGIC     expr: item.brand
# MAGIC   - name: Warehouse ID
# MAGIC     expr: warehouse.warehouse_id
# MAGIC   - name: Warehouse Name
# MAGIC     expr: warehouse.warehouse_name
# MAGIC   - name: Snapshot Date
# MAGIC     expr: snapshot_date
# MAGIC measures:
# MAGIC   - name: Inventory Quantity
# MAGIC     expr: SUM(quantity_on_hand)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Store metrics metric view definition
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.store_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.dim_store
# MAGIC dimensions:
# MAGIC   - name: Store Key
# MAGIC     expr: store_key
# MAGIC   - name: Store ID
# MAGIC     expr: store_id
# MAGIC   - name: Store Name
# MAGIC     expr: store_name
# MAGIC   - name: City
# MAGIC     expr: store_city
# MAGIC   - name: State
# MAGIC     expr: store_state
# MAGIC measures:
# MAGIC   - name: Store Count
# MAGIC     expr: COUNT(store_key)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Promotion metrics metric view definition
# MAGIC %sql
# MAGIC -- gold.dim_promotion models channels as boolean flags (email/TV) instead of
# MAGIC -- bronze's single channel string column.
# MAGIC CREATE OR REPLACE VIEW workspace.gold.promotion_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.dim_promotion
# MAGIC dimensions:
# MAGIC   - name: Promotion Key
# MAGIC     expr: promo_key
# MAGIC   - name: Promotion ID
# MAGIC     expr: promo_id
# MAGIC   - name: Promotion Name
# MAGIC     expr: promo_name
# MAGIC   - name: Purpose
# MAGIC     expr: promo_purpose
# MAGIC   - name: Email Channel
# MAGIC     expr: channel_email
# MAGIC   - name: TV Channel
# MAGIC     expr: channel_tv
# MAGIC   - name: Discount Active
# MAGIC     expr: is_discount_active
# MAGIC measures:
# MAGIC   - name: Promotion Count
# MAGIC     expr: COUNT(promo_key)
# MAGIC $$

# COMMAND ----------

# DBTITLE 1,Item metrics metric view definition
# MAGIC %sql
# MAGIC CREATE OR REPLACE VIEW workspace.gold.item_metrics
# MAGIC WITH METRICS
# MAGIC LANGUAGE YAML
# MAGIC AS $$
# MAGIC version: 1.1
# MAGIC source: workspace.gold.dim_item
# MAGIC dimensions:
# MAGIC   - name: Item Key
# MAGIC     expr: item_key
# MAGIC   - name: Item ID
# MAGIC     expr: item_id
# MAGIC   - name: Item Name
# MAGIC     expr: item_name
# MAGIC   - name: Brand
# MAGIC     expr: brand
# MAGIC   - name: Manufacturer
# MAGIC     expr: manufacturer
# MAGIC   - name: Category
# MAGIC     expr: category
# MAGIC   - name: Class
# MAGIC     expr: class
# MAGIC measures:
# MAGIC   - name: Item Count
# MAGIC     expr: COUNT(item_key)
# MAGIC $$