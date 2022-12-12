select
    EMP_CODE as CODE,
    EMP_ENG_NAME as ENG_NAME
from
    EMP
group by
    EMP_CODE
having
    sum(
        length(EMP_ENG_NAME) * 2 - length(replace(EMP_ENG_NAME, 'S', '')) - length(replace(EMP_ENG_NAME, 's', ''))
    ) >= 2
order by
    EMP_CODE;