const API_URL = "http://localhost:3000/api/partners";

export const getAllPartners = async () => {
  const response = await fetch(API_URL);
  if (!response.ok) throw new Error("Không thể tải danh sách đối tác");
  return response.json();
};

export const addPartner = async (data) => {
  const response = await fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  const resData = await response.json();
  if (!response.ok) throw new Error(resData.error || "Thêm đối tác thất bại");
  return resData;
};

export const recordSponsorship = async (data) => {
  const response = await fetch(`${API_URL}/sponsor`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  const resData = await response.json();
  if (!response.ok) throw new Error(resData.error || "Ký kết tài trợ thất bại");
  return resData;
};
