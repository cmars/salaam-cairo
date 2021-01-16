%builtins output

from starkware.cairo.common.alloc import alloc

func array_sum(arr, size) -> (sum):
	if size == 0:
		return (sum=0)
	end

	let (sum_of_rest) = array_sum(arr=arr + 1, size=size - 1)
	return (sum=[arr] + sum_of_rest)
end

func array_product_even(arr, size) -> (product):
	if size == 0:
		return (product=1)
	end
	# TODO: properly range check size with builtin, so this also works for
	# odd-sized arrays

	let (product_of_rest) = array_product_even(arr=arr + 2, size=size - 2)
	return (product=[arr] * product_of_rest)
end

func main(output_ptr) -> (output_ptr):
	const ARRAY_SIZE = 4

	# Run both the array_sum and array_product_even functions. What's
	# interesting is that the inputs need to be copied, and the input, call and
	# output need to be grouped like this, or the compiler errors with a
	# revoked reference.

	let (sum_in) = alloc()
	assert [sum_in] = 9
	assert [sum_in + 1] = 16
	assert [sum_in + 2] = 25
	assert [sum_in + 3] = 36
	let (sum) = array_sum(arr=sum_in, size=ARRAY_SIZE)
	assert [output_ptr] = sum

	let (prod_in) = alloc()
	assert [prod_in] = 9
	assert [prod_in + 1] = 16
	assert [prod_in + 2] = 25
	assert [prod_in + 3] = 36
	let (prod) = array_product_even(arr=prod_in, size=ARRAY_SIZE)
	assert [output_ptr + 1] = prod

	return (output_ptr = output_ptr + 2)
end
