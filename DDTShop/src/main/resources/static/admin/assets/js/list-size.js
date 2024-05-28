var baseUrl = new URL(window.location.href).origin;

function deleteSize(id, name) {
	Swal.fire({
		title: 'Bạn có muốn xoá?',
		text: "Xoá kích thước " + name + " sẽ không khôi phục được!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Xác nhận!'
	}).then((result) => {
		if (result.isConfirmed) {
			axios({
				method: 'DELETE',
				url: baseUrl + "/sizes/delete/" + id,
				responseType: 'json'  // Sửa thành json để có thể xử lý response dưới dạng JSON
			})
				.then(function(response) {
					// Kiểm tra response từ server
					if (response.status === 200) {
						Swal.fire({
							title: 'Đã xoá!',
							text: 'Đã xoá kích thước thành công.',
							icon: 'success',
							confirmButtonText: 'OK'
						}).then((result) => {
							if (result.isConfirmed) {
								location.reload(true);
							}
						});
					} else {
						// Nếu có lỗi 400, hiển thị thông báo lỗi từ response
						Swal.fire(
							'Lỗi!',
							response.data,  // Supposing the error message is in the response data
							'error'
						)
					}
				})
				.catch(function(error) {
					// Xử lý lỗi trong trường hợp request không thành công
					console.error('Error deleting size:', error);
					Swal.fire(
						'Lỗi!',
						'Không thể xóa kích thước có sản phẩm liên quan',
						'error'
					);
				});
		}
	})
}
