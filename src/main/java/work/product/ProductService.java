package work.product;

import java.util.List;
import java.util.Map;

public interface ProductService {
	public List<Map<String, String>> retrieveProductList(Map<String, String> productParam);
	public List<Map<String, String>> retrieveProductListForMain();

	public List<Map<String, String>> retrieveProductListForRegular();
	public List<Map<String, String>> retrieveProductListForCoffee();
	public List<Map<String, String>> retrieveProductListForGoods();
	public List<Map<String, String>> retrieveProductListForPresent();

	public Map<String, String> retrieveProduct(Map<String, String> productParam);

	public void createProduct(ProductBean product);
	public void updateProduct(ProductBean product);

	public void updateProductCountMinus(Map<String, String> productParam);
	public void updateProductCountPlus(Map<String, String> productParam);

	public String retrieveMaxProductCode();

	public List<Map<String, String>> retrieveStatisticsForStock(Map<String, String> productParam);

	public List<Map<String, String>> retrieveStatisticsForSell();

}
