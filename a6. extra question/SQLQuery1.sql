select * from TBL_ORDER

---q for each category, find the how much is the order is the varying from the maximum sales

select *, max_cate_sales - sales as differnce_sales
select CATEGORY, SALES, SUM(SALES), sum(sales) over(partition by category) as differ from TBL_ORDER 