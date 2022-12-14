SELECT
    ROUND(AVG(TOTAL_VALUE), 0) as SA_MEDIAN
FROM
    (
        SELECT
            TOTAL_VALUE
        FROM
            CONVENIENCE
        where
            SURVEY_YEAR = '2019'
            and KIND_CODE = '100'
        ORDER BY
            TOTAL_VALUE desc
        LIMIT
            2 - (
                SELECT
                    COUNT(*)
                FROM
                    CONVENIENCE
                where
                    SURVEY_YEAR = '2019'
                    and KIND_CODE = '100'
            ) % 2 OFFSET (
                SELECT
                    (COUNT(*) - 1) / 2
                FROM
                    CONVENIENCE
                where
                    SURVEY_YEAR = '2019'
                    and KIND_CODE = '100'
            )
    );