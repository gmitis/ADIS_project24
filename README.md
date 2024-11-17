## Project Description
tba

## Running Services:

Step 1: Download Repository
``` bash
 git clone https://github.com/gmitis/ADIS_project24 && cd ADIS_project24
```

Step 2: Navigate to the branch you need
``` bash
 git branch -m BranchName
```

Step 3: Raise services that you need
``` bash
 docker-compose up -d --build --force-recreate ServiceName1 ServiceName2 ...
```

Step 4: Test cluster
``` bash
# on the UI sql section run
SELECT
    o.orderkey,
    o.custkey,
    o.orderstatus,
    o.totalprice,
    o.orderdate,
    o.orderpriority,
    l.quantity,
    l.extendedprice,
    l.discount,
    l.tax,
    (l.extendedprice * (1 - l.discount)) AS charge
FROM
    tpch.sf1.orders o   -- Specify tpch.sf1 schema for orders
JOIN
    tpch.sf1.lineitem l  -- Specify tpch.sf1 schema for lineitem
ON
    o.orderkey = l.orderkey  -- Corrected join condition
WHERE
    o.orderstatus = 'F'  -- Filter for completed orders
    AND l.shipdate > DATE '1994-01-01'  -- Filter for shipments after 1994-01-01
ORDER BY
    o.orderdate
limit 100
```
