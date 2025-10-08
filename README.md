# Assignments for course "CS310 Databases"

## Assignment 1

I simulated a database for a dog hotel. There are 5 tables:

1) **Dogs** - with their ids, ids of the owners, breeds etc.
2) **Dog names** - with dogs' names
3) **Owners** - with owners' contact information
4) **Rooms** - with dogs that are located in the certain room and the number of dogs that can live in the room in general
5) **Check in** - with information of dogs' arrival, payment etc.

I was looking for information about owners of the dogs whose stay was not payed. There were also other criterias: I was looking for rooms for 2+ dogs that had free space when the "unpaid" dogs were living there. I ordered the final list in the descending order and took first 5 entries.

### Logic within the query:
- *dogs_w_names CTE*: here I combined dogs with their names, owners and rooms
- *join with subselect*: then I inner-joined "dogs with names" with information about their stay in the hotel: check-out day and payment verification
- *grouping*: next I grouped the table by owners, concatenating dogs' names, breeds, colors etc. and preserving owners' contacts
- *getting TOP-5*: finally, I sorted table by number of "unpaid" dogs per owner in descending order and took first 5 entries
