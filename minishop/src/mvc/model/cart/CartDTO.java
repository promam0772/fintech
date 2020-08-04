package mvc.model.cart;

public class CartDTO {

	private int cartId;
	private String m_id;
	private int p_id;
	private String p_name;
	private int totalQty;
	private int totalPrice;
	
	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getP_id() {
		return p_id;
	}

	public void setP_id(int p_id) {
		this.p_id = p_id;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getTotalQty() {
		return totalQty;
	}

	public void setTotalQyt(int totalQty) {
		this.totalQty = totalQty;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "CartDTO [cartId=" + cartId + ", m_id=" + m_id + ", p_id" + p_id
                + ", p_name=" + p_name + ", totalQty=" + totalQty + ", totalPrice=" + totalPrice +  "]";
    }
	
}
