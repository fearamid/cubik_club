enum CommunityLinkType { any, guide, example, post, process }

class CommunityLink {
  final String title;
  final String link;
  final CommunityLinkType type;

  const CommunityLink({
    required this.title,
    required this.link,
    this.type = CommunityLinkType.any,
  });
}
