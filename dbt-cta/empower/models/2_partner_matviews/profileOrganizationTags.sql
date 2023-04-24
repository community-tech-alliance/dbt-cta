select
    profileEid,
    tagId,
from {{ source('cta','profileorganizationtags_base') }}