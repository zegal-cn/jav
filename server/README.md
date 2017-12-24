# 

## migrations

rails g model Actress cid:integer:index name name_cn name_en avatar count:integer rate:integer description:text description_cn:text

rails g model Movie cid:integer:index title publisher:references producer:references published_on:date  series:references level:integer desc

rails g migration CreateJoinTableActressMovie actress movie

rails g model Maker cid:integer:index name name_cn name_en logo rate:integer description:text description_cn:text

rails g model Cover name thumbnail movie:references

rails g model Screenshot name thumbnail movie:references sort:integer

rails g model Series cid:integer:index name name_cn name_en rate:integer maker:references description:text description_cn:text




### redis

http://blog.csdn.net/u010982856/article/details/51658184