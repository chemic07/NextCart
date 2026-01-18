export interface ProductModel {
  name: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  quantity: number;
  ratings: Rating[];
}

interface Rating {
  userId: string;
  rating: number;
}
