-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_survey_result') }}

select
    answerId,
    contactId,
    scheduleId,
    questionId,
    questionText,
    answerActionId,
    answerValue,
    digit,
    dateCreated,
   {{ dbt_utils.surrogate_key([
     'answerId',
    'contactId',
    'scheduleId',
    'questionId',
    'questionText',
    'answerActionId',
    'answerValue',
    'digit',
    'dateCreated'
    ]) }} as survey_result_hashid
from {{ source('cta', '_stg_survey_result') }}
