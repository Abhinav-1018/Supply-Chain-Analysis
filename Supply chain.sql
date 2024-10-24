--Total Revenue by Product Type
select [Product type], round(sum([Revenue generated]),2) as [total revenue generated] from supply_chain_data
group by [Product type];

--Shipping Costs by Carrier
select [Shipping carriers], round(avg([Shipping costs]),2) as [avg shipping cost] from supply_chain_data
group by [Shipping carriers];

--Supplier Performance Analysis
select [Supplier name], round(avg([Lead times]),2) as [avg lead times] from supply_chain_data
group by [Supplier name] having round(avg([Lead times]),2)<(select avg([Lead times]) from supply_chain_data);

--Total Products Sold by Location
select [Location], sum([Number of products sold]) as [total products sold] from supply_chain_data
group by [Location]
order by sum([Number of products sold]) desc;

--Defect Rates by Inspection Results
select[Inspection results], round(avg([Defect rates]),2) as [avg defect rates] from supply_chain_data
group by [Inspection results];

--Ranking Products by Profitability
select [SKU], [Product type], round(([Revenue generated] - [Manufacturing costs] - [Shipping costs]),2) as profit,
DENSE_RANK() over(partition by [Product type] order by [Revenue generated],[Manufacturing costs],[Shipping costs] desc) as rank 
from supply_chain_data;

--Top 5 Shipping Carriers by Cost Efficiency
select [Product type], [Shipping carriers], round(avg([Shipping costs]),2) as [avg shipping cost],
DENSE_RANK() over(partition by [Product type] order by avg([Shipping costs])) as rank
from supply_chain_data
group by [Shipping carriers], [Product type];

--Average Production Volume by Product Type
select [Product type], avg([Production volumes]) as [avg production volumes] from supply_chain_data
group by [Product type]