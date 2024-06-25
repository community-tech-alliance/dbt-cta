-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_ivr_contact') }}

select
  ivrResultId,
  scheduleId,
  programId,
  programName,
  scheduleName,
  "to",
  disposition,
  dateCreated,
  duration,
  contactId,
  externalId,
  contactFirstName,
  contactLastName,
  contactAge,
  contactGender,
  contactRace,
  contactExtra1,
  contactExtra2,
  contactExtra3,
  contactExtra4,
  contactExtra5,
  contactExtra6,
  contactExtra7,
  contactExtra8,
  contactExtra9,
  contactExtra10,
  contactExtra11,
  contactExtra12,
  contactExtra13,
  contactExtra14,
  contactExtra15,
  contactExtra16,
  contactExtra17,
  contactExtra18,
  contactExtra19,
  contactExtra20,
  contactExtra21,
  contactExtra22,
  contactExtra23,
  contactExtra24,
  contactExtra25,
  contactExtra26,
  contactExtra27,
  contactExtra28,
  contactExtra29,
  contactExtra30,
  {{ dbt_utils.surrogate_key([
    'ivrResultId',
    'scheduleId',
    'programId',
    'programName',
    'scheduleName',
    'disposition',
    'dateCreated',
    'duration',
    'contactId',
    'externalId',
    'contactFirstName',
    'contactLastName',
    'contactAge',
    'contactGender',
    'contactRace',
    'contactExtra1',
    'contactExtra2',
    'contactExtra3',
    'contactExtra4',
    'contactExtra5',
    'contactExtra6',
    'contactExtra7',
    'contactExtra8',
    'contactExtra9',
    'contactExtra10',
    'contactExtra11',
    'contactExtra12',
    'contactExtra13',
    'contactExtra14',
    'contactExtra15',
    'contactExtra16',
    'contactExtra17',
    'contactExtra18',
    'contactExtra19',
    'contactExtra20',
    'contactExtra21',
    'contactExtra22',
    'contactExtra23',
    'contactExtra24',
    'contactExtra25',
    'contactExtra26',
    'contactExtra27',
    'contactExtra28',
    'contactExtra29',
    'contactExtra30',
    ]) }} as ivr_contact_hashid
from {{ source('cta', '_stg_ivr_contact') }}