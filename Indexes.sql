-- ------------------------------------------------------------------------------Index
-- clustured on each PK, to index data which sorted in physical disk
-- normal (non clustured) can apply it on important cols 

create INDEX idx_name
on twitter (name)

drop INDEX twitter.idx_name