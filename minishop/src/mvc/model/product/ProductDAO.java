package mvc.model.product;

import java.util.ArrayList;

public class ProductDAO {

	private ArrayList<ProductDTO> listOfProducts = new ArrayList<ProductDTO>();

		//모든 제품 목록을 가져오는 메서드
		public ArrayList<ProductDTO> getAllProducts(){
			return listOfProducts;
		}
		//제품 상세보기를 위해 해당 제품 찾기
		public ProductDTO getProductById(String productId) {
			ProductDTO productById = null;
			
			for(int i=0;i<listOfProducts.size();i++) {
				ProductDTO product = listOfProducts.get(i);
				if(product != null && product.getProductId() != null && product.getProductId().equals(productId)) {
					productById = product;
					break;
				}
			}
			return productById;
		}
		
		public void addProduct(ProductDTO product) {
			/* System.out.println(product); */
			listOfProducts.add(product);
		}
	
	
}
