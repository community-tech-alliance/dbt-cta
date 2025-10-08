select *
from {{ source('cta', 'spam_spamchecklog_base') }}
