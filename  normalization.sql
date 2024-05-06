
-- ------------------------------
/*
1- ST NF
    1- PK 4 each row
    2- atomic value
    3- distincit name 4 each col

2- ND NF 
    1- ST NF
    2- no partial key

3- 3d NF
    1- ST, ND NF
    2- no unrelated data (transitive dependency) can get col based on another col

4,5- Boyce Codd NF


*/

create DATABASE car_data;