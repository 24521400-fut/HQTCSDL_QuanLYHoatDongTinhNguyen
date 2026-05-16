const API_URL = "http://localhost:3000/api/admin-finance";

export const getPendingMonetary = async (maCD) => {
  const response = await fetch(`${API_URL}/pending-monetary/${maCD}`);
  if (!response.ok) throw new Error("Không thể tải danh sách tài trợ tiền");
  return response.json();
};

export const getPendingItems = async (maCD) => {
  const response = await fetch(`${API_URL}/pending-items/${maCD}`);
  if (!response.ok) throw new Error("Không thể tải danh sách tài trợ vật phẩm");
  return response.json();
};

export const approveMonetary = async (id, type) => {
  const response = await fetch(`${API_URL}/approve-monetary`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id, type }),
  });
  if (!response.ok) throw new Error("Duyệt tài trợ tiền thất bại");
  return response.json();
};

export const approveItems = async (id) => {
  const response = await fetch(`${API_URL}/approve-items`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id }),
  });
  if (!response.ok) throw new Error("Duyệt tài trợ vật phẩm thất bại");
  return response.json();
};
