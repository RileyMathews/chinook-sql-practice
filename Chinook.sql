-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Customer.Country != "USA"

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.
SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Customer.Country = "Brazil"

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
SELECT Customer.FirstName, Customer.LastName, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.BillingCountry
FROM Customer
LEFT JOIN Invoice on Customer.CustomerId = Invoice.CustomerId
WHERE Customer.Country = 'Brazil'

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.
SELECT FirstName, LastName, Title
FROM Employee
WHERE Title = 'Sales Support Agent'

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry
FROM Invoice

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT Employee.FirstName, Employee.LastName, Invoice.InvoiceId
FROM Employee, Customer, Invoice
WHERE Employee.EmployeeId=Customer.SupportRepId
AND Customer.CustomerId=Invoice.CustomerId

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT Invoice.Total, Customer.FirstName, Customer.Country, Employee.FirstName
FROM Invoice, Customer, Employee
WHERE Customer.CustomerId=Invoice.CustomerId
AND Customer.SupportRepId=Employee.EmployeeId

-- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?
SELECT COUNT(*)
FROM Invoice
WHERE Invoice.InvoiceDate LIKE "2009%" OR Invoice.InvoiceDate LIKE "2011%"

-- total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT Sum(Invoice.Total)
FROM Invoice
WHERE Invoice.InvoiceDate LIKE "2009%" 

SELECT Sum(Invoice.Total)
FROM Invoice
WHERE Invoice.InvoiceDate LIKE "2011%" 

-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT Count(*)
FROM InvoiceLine
WHERE InvoiceLine.InvoiceId=37

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT Count(*), Invoice.InvoiceId
FROM InvoiceLine
JOIN Invoice ON Invoice.InvoiceId=InvoiceLine.InvoiceId
GROUP BY InvoiceLine.InvoiceId

-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.
SELECT Track.Name, InvoiceLine.InvoiceId, InvoiceLine.InvoiceLineId
FROM InvoiceLine
LEFT JOIN Track ON InvoiceLine.TrackId=Track.TrackId

-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT Track.Name, InvoiceLine.InvoiceId, InvoiceLine.InvoiceLineId, Artist.Name as ArtistName
FROM InvoiceLine
LEFT JOIN Track ON InvoiceLine.TrackId=Track.TrackId
LEFT JOIN Album ON Track.AlbumId=Album.AlbumId
LEFT JOIN Artist ON Album.ArtistId=Artist.ArtistId

-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT Count(Customer.Country), Customer.Country
FROM Customer, Invoice
WHERE Invoice.CustomerId=Customer.CustomerId
GROUP BY Customer.Country

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
SELECT Count(PlaylistTrack.TrackId), Playlist.Name
FROM Playlist, PlaylistTrack
WHERE PlaylistTrack.PlaylistId=Playlist.PlaylistId
GROUP BY Playlist.PlaylistId

-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
SELECT Track.Name, Genre.Name, Album.Title, MediaType.Name
FROM Track, Genre, Album, MediaType
WHERE Track.GenreId=Genre.GenreId
AND Track.AlbumId=Album.AlbumId
AND Track.MediaTypeId=MediaType.MediaTypeId

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT Count(InvoiceLine.InvoiceLineId), Invoice.InvoiceId
FROM InvoiceLine, Invoice
WHERE InvoiceLine.InvoiceId=Invoice.InvoiceId
GROUP BY Invoice.InvoiceId

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
SELECT Count(Invoice.Total), Employee.FirstName
FROM Invoice, Customer, Employee
WHERE Invoice.CustomerId=Customer.CustomerId
AND Customer.SupportRepId=Employee.EmployeeId
GROUP BY Employee.EmployeeId

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?
SELECT Max(Invoice.Total), Employee.FirstName
FROM Invoice, Customer, Employee
WHERE Invoice.CustomerId=Customer.CustomerId
AND Customer.SupportRepId=Employee.EmployeeId
AND Invoice.InvoiceDate LIKE "2009%"

-- Hint: Use the MAX function on a subquery.

-- top_agent.sql: Which sales agent made the most in sales over all?
SELECT Max(Invoice.Total), Employee.FirstName
FROM Invoice, Customer, Employee
WHERE Invoice.CustomerId=Customer.CustomerId
AND Customer.SupportRepId=Employee.EmployeeId


-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.
SELECT Count(Customer.CustomerId), Employee.FirstName
FROM Customer, Employee
WHERE Customer.SupportRepId=Employee.EmployeeId
GROUP BY Employee.EmployeeId

-- sales_per_country.sql: Provide a query that shows the total sales per country.
SELECT Count(Invoice.InvoiceId), Customer.Country
FROM Invoice, Customer
WHERE Invoice.CustomerId=Customer.CustomerId
GROUP BY Customer.Country

-- top_country.sql: Which country's customers spent the most?
SELECT Max(Invoice.Total), Customer.Country
FROM Invoice, Customer
WHERE Invoice.CustomerId=Customer.CustomerId

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
SELECT Max(InvoiceLine.TrackId), Track.Name, Count(InvoiceLine.TrackId)
FROM InvoiceLine, Track
WHERE InvoiceLine.TrackId=Track.TrackId

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.
SELECT Count(InvoiceLine.TrackId) as trackcount, Track.Name
FROM InvoiceLine, Track
WHERE InvoiceLine.TrackId=Track.TrackId
Group BY Track.Name
ORDER BY trackcount DESC
LIMIT 5

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
SELECT count(Track.TrackId), Artist.Name
FROM InvoiceLine
JOIN Invoice on InvoiceLine.InvoiceId=Invoice.InvoiceId
JOIN Track ON Track.TrackId=InvoiceLine.TrackId
JOIN Album ON Track.AlbumId=Album.AlbumId
JOIN Artist ON Artist.ArtistId=Album.ArtistId
Group BY Artist.Name
ORDER BY Track.TrackID DESC
LIMIT 3

-- top_media_type.sql: Provide a query that shows the most purchased Media Type.
SELECT Count(MediaType.MediaTypeId) as mediacount, MediaType.Name
FROM MediaType
LEFT JOIN Track ON Track.MediaTypeId=MediaType.MediaTypeId
LEFT JOIN InvoiceLine ON InvoiceLine.TrackId=MediaType.MediaTypeId
GROUP BY MediaType.MediaTypeId
ORDER BY mediacount desc
LIMIT 1