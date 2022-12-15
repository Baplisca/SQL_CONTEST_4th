WITH RECURSIVE cnt(x) AS (
    VALUES
        (julianday(replace('2022/08/01', '/', '-')))
    UNION
    ALL
    SELECT
        x + 1
    FROM
        cnt
    WHERE
        x < julianday(replace('2022/08/31', '/', '-'))
),
ans AS (
    SELECT
        strftime('%Y-%m-%d', x) AS DATE,
        strftime('%w', x) as WK,
        0 as CO
    FROM
        cnt
)
SELECT
    ans.DATE as REGIST_DATE,
    CASE
        ans.WK
        WHEN '1' then '月'
        WHEN '2' then '火'
        WHEN '3' then '水'
        WHEN '4' then '木'
        WHEN '5' then '金'
        WHEN '6' then '土'
        WHEN '0' then '日'
    END as 'WK',
    ifnull(ans.CO + b.TOTAL, 0) as TOTAL
FROM
    ans
    left join (
        select
            SUBSTR(CONFIRMED_AT, 0, 11) as REGIST_DATE,
            COUNT(*) as TOTAL
        from
            USERS
        where
            VALID_FLG = '1'
            and CONFIRMED_AT > '2022-08-01'
            and CONFIRMED_AT < '2022-09-01'
        group by
            SUBSTR(CONFIRMED_AT, 0, 11)
        order by
            SUBSTR(CONFIRMED_AT, 0, 11)
    ) b ON ans.DATE = b.REGIST_DATE
order by
    ans.DATE;