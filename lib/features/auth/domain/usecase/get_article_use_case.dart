

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';

class GetArticleUseCase extends UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticle();
  }
}
