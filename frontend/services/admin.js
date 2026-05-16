const API_URL = "http://localhost:3000/api/admin";

export const createAccount = async (data) => {
  const response = await fetch(`${API_URL}/accounts`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  if (!response.ok) throw new Error("Tạo tài khoản thất bại");
  return response.json();
};

export const getAllAccounts = async () => {
  const response = await fetch(`${API_URL}/accounts`);
  if (!response.ok) throw new Error("Không thể tải danh sách tài khoản");
  return response.json();
};

export const updateAccountStatus = async (maTK, status) => {
  const response = await fetch(`${API_URL}/accounts/${maTK}/status`, {
    method: "PATCH",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ status }),
  });
  const data = await response.json();
  if (!response.ok) throw new Error(data.error || "Cập nhật trạng thái thất bại");
  return data;
};

export const deleteAccount = async (maTK) => {
  const response = await fetch(`${API_URL}/accounts/${maTK}`, {
    method: "DELETE",
  });
  const data = await response.json();
  if (!response.ok) throw new Error(data.error || "Xóa tài khoản thất bại");
  return data;
};
