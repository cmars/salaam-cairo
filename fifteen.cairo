struct Location:
	member row = 0
	member col = 1
	const SIZE = 2
end

func verify_valid_location(loc : Location*):
    # Check that row is in the range 0-3
	tempvar row = loc.row
	assert row * (row - 1) * (row - 2) * (row - 3) = 0

	# Check that the col is in the range 0-3
	tempvar col = loc.col
	assert col * (col - 1) * (col - 2) * (col - 3) = 0

	return ()
end
