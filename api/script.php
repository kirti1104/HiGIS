<!DOCTYPE html>
<html>
	<head>
		<style>
			table, th, td {
				 border: 1px solid black;
			}
		</style>
	</head>
	<body>

	<form action="query.php" method="get">
		Which Country you are looking for?<br><br>
		<input type="text" name="ctr">
		<input type="submit" name="submit" value="ok">
	</form>

	</body>
</html>

<!--
output
------

	Levels:
	[ polypolygon [ polygon [ polyline [ point ], [ point ] ] ] ]

	example:
	[[[[15.1654, 19.651687], [65.151,135.3517], … []], []]]

-->
