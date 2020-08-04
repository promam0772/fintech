package mvc.model.cart;

public class CartDAO {
	
	private static CartDAO instance;
	
	private CartDAO() {}
	
	public static CartDAO getInstance() {
		if(instance == null)
			instance = new CartDAO();
		return instance;
	}
	
	
	
}
