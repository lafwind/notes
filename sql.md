### SQL

* SELECT

```sql
SELECT column FROM table;

SELECT column_1, column FROM table;

SELECT * FORM table;

SELECT DISTINCT column FROM table;  --只返回不同值（唯一性）

SELECT column FROM table LIMIT 5; -- TOP; FETCH FIRST 5 ROWS ONLY

SELECT column FROM table LIMIT 5 OFFSET 5;

SELECT column FROM table LIMIT 5, 5; -- MySQL & MariaDB
```

* ORDER BY

```sql
-- ORDER BY 子句必须是最后一条子句

SELECT column FROM table ORDER BY column;

SELECT column_1, column_2, column_3
FROM table
ORDER BY column_1, column_3;

SELECT column_1, column_2, column_3
FROM table
ORDER BY 2, 3; -- 2: second in select list => column_2; 3: 同理 => column_3

-- 降序排序(DESCENDING)；默认升序ASC(ASCENDING)
SELECT column FROM table ORDER BY column DESC;

SELECT column_1, column_2, column_3
FORM table
ORDER BY column_1 DESC, column_2; -- DESC只作用于column_1

-- 区分大小写？按系统来。
```

* WHERE

```sql
-- 指定搜索条件（过滤条件）
-- 同时使用ORDER BY和WHERE子句时，应该让ORDER BY位于WHERE子句之后，否则产生错误

-- WHERE子句支持的操作符：=，<>（不等于），!=（也是不等于），<，<=，!<（不小于），
-- >，>=，!>（不大于），BETWEEN...AND...（在指定的两个值之间），IS NULL（为NULL值）
-- 上述有些操作符是冗余的，如（<>和!=，!<和>=），并非所有DBMS都支持，应视DBMS的情况而定

-- 一些DBMS可能有其他特殊操作符，应视DBMS的情况而定

SELECT column FROM table WHERE column = value;

SELECT column FROM table WHERE column < value;

SELECT column FROM table WHERE column <> value;

SELECT column FROM table WHERE column BETWEEN value_1 AND value_2;

-- 建表时，表设计人员可以指定其中的列能否包含空值
-- 一个列不包含值时，称其包含空值NULL
-- NULL和0，空字符串，或仅仅包含空格不同
-- 选择不包含指定值的行时，含NULL的行不会返回

SELECT column FROM table WHERE column IS NULL

-- AND操作符：返回满足所有条件的行；可有多个AND
SELECT column_1, column_2
FROM table
WHERE column_1 = value_1 AND column_2 != value_2;

-- OR操作符：返回满足任一条件；可有多个OR；
-- 很多DBMS在满足第一个条件后就返回了，第二个条件不管如何，这一行也要返回
SELECT column_1, column_2, column_3
FROM table
WHERE column_1 > value_1 OR column_2 IS NULL;

-- AND和OR组合： AND优先级高于OR；圆括号比前两者优先级更高
-- 在有AND和OR操作符的WHERE子句中，应使用圆括号来明确分组操作符，
-- 不过分依赖默认求值顺序（不清晰）；用圆括号没什么坏处，可消除歧义
SELECT column_1, column_2, column_3
FROM table
WHERE column_1 <> value_1 OR column_2 > value_2 AND value_3 IS NULL;

-- 上面语句等价于下面的语句

SELECT column_1, column_2, column_3
FROM table
WHERE column_1 <> value_1 OR (column_2 > value_2 AND value_3 IS NULL);

-- IN, 功能与OR相当
-- 有很多合法选项时，语法更清晰直观；
-- 相较于OR，更快
-- 求值顺序更易管理
-- 可以包含其他SELECT语句，能够更动态的建立WHERE子句！！！

SELECT column_1, column_2
FORM table
WHERE column_1 IN (value_1, value_2);

-- NOT，否定其后所跟的任何条件
-- 从不单独使用，总是与其他操作符一起使用
-- 与IN操作符联合使用时，NOT可以非常简单地找出与条件列表不匹配的行

SELECT column
FROM table
WHERE NOT column = value;

-- LIKE

-- %：任意字符出现任意次数（包括0个字符，但不包含NULL）
-- Microsoft Access是用*而不是%

-- 找出所有以Wind开头的
SELECT column
FORM table
WHERE column LIKE 'Wind%'; --根据不同DBMS，可能需要区分大小写

SELECT column
FORM table
WHERE column LIKE '%Wind%';

SELECT column
FORM table
WHERE column LIKE 'W%d';

SELECT column
FORM table
WHERE column LIKE '%W%d%';

-- _：只匹配单个字符，刚好一个，不多也不少
-- DB2 不支持_操作符
-- Microsoft Access是用?而不是_

SELECT column
FORM table
WHERE column LIKE 'W__d'; -- 匹配Wind，无法匹配World或Wed

SELECT column
FORM table
WHERE column LIKE 'W%d'; -- 匹配Wind, World和Wed

-- [] 指定一个字符集
-- 利用^来否定：[^]；Microsoft Access用!而不是^
-- 也可用NOT来否定，^ 的唯一优点是在使用多个WHERE子句时可以简化语法
-- 只有Microsoft Access和SQL Server中的[]支持集合

SELECT column
FROM table
WHERE column LIKE '[JK]%'; -- 匹配J或K开头

SELECT column
FROM table
WHERE column LIKE '[^JK]%'; -- 不匹配J或K开头

SELECT column
FROM table
WHERE NOT column LIKE '[JK]%'; -- 不匹配J或K开头

-- 通配符较耗时

-- 不过度使用通配符，如其他操作符可达到相同目的，用其他操作符
-- 如确实需要使用通配符，不要将它们放在搜索模式的开始处，河阳搜索起来最慢
-- 注意通配符位置，不然可能无法返回想要的数据
```

* 计算字段

```ruby

-- 拼接字段
SELECT column_1 + ':' + column_2
FROM table;

SELECT column_1 || ':' || column_2
FROM table;

SELECT RTRIM(column_1) + ':' + column_2  -- 去掉column_1右边空格
FROM table;

SELECT column_1 + ':' + column_2 AS column -- AS 可选不过，最好都加上，最佳实践
FROM table;

SELECT column_1, column_2 * 100 AS column -- 支持+-*/
FROM table;

-- 应否使用函数？
-- 取决于自身。因为函数可移植性不好，但又比较简单高效（相对于在应用程序里实现）
-- 如用了函数，应注释清楚

-- 文本处理函数：LEFT(), LENGTH(), LOWER(), LTRIM(), RIGHT(), RTRIM(), SOUNDEX(), SOUNDEX
-- 日期时间处理函数：各DBMS很不一致，移植性差

-- MySQL MariaDB
SELECT column
FROM table
WHERE YEAR(column_date) = 2015;

-- postgresql
SELECT column
FROM table
WHERE DATE_PART('year', column_date) = 2015; -- 各DBMS处理方式不同，详见文档

-- 数值处理函数：各DBMS最一致，ABS(), COS(), EXP(), PI(), SIN(), SQRT(), TAN()

-- 聚集函数

-- AVG()：只能用于单列，如为了获得多列的avg，需使用多个AVG()；忽略值为NULL的行
SELECT AVG(column) AS avg_column
FROM table;

SELECT AVG(column) AS avg_column
FROM table
WHERE column = value;

-- COUNT()：计数
-- COUNT(*) 对表中的行计数，不管列中是否包含NULL，不忽略NULL
-- COUNT(column) 对特定的列中具有值的行计数，忽略NULL

SELECT COUNT(*) as num
FROM table;

SELECT COUNT(column) as num_column
FROM table;

-- MAX()：指定列中的最大值，忽略值为NULL的行
-- MIN()：指定列中的最小值，忽略值为NULL的行
-- 对非数值使用，如文本，返回的是列排序后最后（MAX）或最前（MIN）的行

SELECT MAX(column) AS max_column
FROM table;

SELECT MIN(column) AS min_column
FROM table;

-- SUM()：求和，会忽略值为NULL的行
SELECT SUM(column) AS sum_column
FROM table;

SELECT SUM(column_1 * column_2) AS sum_column
FROM table
WHERE column_1 = value;

-- DISTINCT: 只包含不同的值
-- DISTINCT 不能用于COUNT(*)
-- DISTINCT 必须使用列名，不能用于计算或表达式

SELECT AVG(DISTINCT column) AS avg_column
FROM table;

SELECT COUNT(*) AS num_column
      MIN(column) AS min_column
      MAX(column) AS max_column
      AVG(column) AS avg_column
      SUM(column) AS sum_column
	  FROM table;

-- 分组
-- GROUP BY: GROUP BY子句必须出现在WHERE子句之后, ORDER BY子句之前
-- 可以包含任意数目的列, 所以可以对分组进行嵌套, 更细致地进行分组
-- 如果在GROUP BY子句中嵌套了分组, 数据将在最后指定的分组汇总
-- GROUP BY列出的每一列都必须是检索列或有效的表达式(但不能是表达函数)
-- 如果在SELECT中使用表达式, 则在GROUP BY子句中也使用相同的表达式
-- 大多数SQL实现不允许GROUP BY列带有长度可变的数据类型(如文本或备注类型)
-- 除聚集计算语句外, SELECT语句中的每一列都必须在GROUP BY子句中给出
-- 如果分组列中包含具有NULL值的行, 则NULL将作为一个分组返回

-- ORDER BY 和 GROUP BY的区别
-- ORDER BY 对产生的输出排序; GROUP BY 对行分组, 但输出可能不是分组的排序
-- ORDER BY 对任意列都可以使用; GROUP BY只能使用选择的列或表达式(SELECT), 而且必须使用每个选择列表达式
-- ORDER BY 不一定需要; 如果和聚集函数一起使用列(或表达式), 怎必须使用

SELECT column, COUNT(*) AS num_column
FROM table
GROUP BY column

-- HAVING: 使用HAVING应该结合GROUP BY子句
-- WHERE子句指定的是行, 它没有分组的功能
-- HAVING子句类似WHERE, 很多WHERE子句都可以由HAVING代替实现(语法相同, 关键有差别而已)
-- HAVING支持所有WHERE操作符
-- WHERE过滤行, HAVING过滤分组
-- WHERE在数据分组前过滤, HAVING在数据分组后过滤

SELECT column, COUNT(\*) AS cn_column
FROM table
GROUP BY column
HAVING COUNT(\*) >= 2

SELECT column, COUNT(*) AS cn_column
FROM table
WHERE column > 2
GROUP BY column
HAVING COUNT(\*) >= 2

```

* SELECT子句及其顺序

| 子句      | 说明             | 是否必须使用           |
|----------|------------------|-----------------------|
| SELECT   | 要返回的列或表达式 | 是                    |
|----------|------------------|-----------------------|
| FROM     | 从中检索数据的表   | 仅在从表里选择数据时使用 |
|----------|------------------|-----------------------|
| WHERE    | 行级过滤          | 否                    |
|----------|------------------|-----------------------|
| GROUP BY | 分组说明          | 尽在按分组计算聚集时使用 |
|----------|------------------|-----------------------|
| HAVING   | 组级过滤          | 否                    |
|----------|------------------|-----------------------|
| ORDER BY | 输出顺序排序       | 否                    |

* 联结

```sql

```
