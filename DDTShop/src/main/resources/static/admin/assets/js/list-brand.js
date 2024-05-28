var baseUrl = new URL(window.location.href).origin;

function deleteBrand(id, name) {
	Swal.fire({
		title: 'Bạn có muốn xoá?',
		text: "Xoá thương hiệu " + name + " sẽ không khôi phục được!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Xác nhận!'
	}).then((result) => {
		if (result.isConfirmed) {
			axios({
				method: 'DELETE',
				url: baseUrl + "/brands/delete/" + id,
				responseType: 'json'  // Sửa thành json để có thể xử lý response dưới dạng JSON
			})
				.then(function(response) {
					// Kiểm tra response từ server
					if (response.status === 200) {
						Swal.fire({
							title: 'Đã xoá!',
							text: 'Đã xoá thương hiệu thành công.',
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
					console.error('Error deleting brand:', error);
					Swal.fire(
						'Lỗi!',
						'Không thể xóa thương hiệu có sản phẩm liên quan',
						'error'
					);
				});
		}
	})
}

var bodyViewBrand = document.getElementById('bodyViewBrand');

function viewBrand(id) {
	axios({
		method: 'GET',
		contentType: "application/json",
		url: baseUrl + "/brands/view/" + id
	})
		.then(function(response) {
			var wrapper = document.createElement('div');
			wrapper.innerHTML = ``;
			bodyViewBrand.innerHTML = ``;
			wrapper.innerHTML = `
			<div class="row">
							<div class="col-sm-12 col-lg-12">
								<table class="table table-borderless">
									<tbody>
										<tr>
											<th>Id</th>
											<td>`+ response.data.id + `</td>
										</tr>
										<tr>
											<th>Tên thương hiệu</th>
											<td>`+ response.data.name + `</td>
										</tr>
										<tr>
											<th>Ngày tạo</th>
											<td>`+ response.data.createdDate + `</td>
										</tr>
										<tr>
											<th>Ngày cập nhật</th>
											<td>`+ response.data.lastModifiedDate + `</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
			`;
			bodyViewBrand.append(wrapper);
		});
}