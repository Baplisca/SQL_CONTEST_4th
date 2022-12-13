delete from
    EMP
where
    EMP_CODE in (
        select
            EMP_CODE
        from
            EMP_INVALID
    )
    and VALID_FLG != '1';