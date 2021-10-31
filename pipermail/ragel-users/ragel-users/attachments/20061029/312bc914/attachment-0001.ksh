Index: ragel/xmlcodegen.cpp
===================================================================
--- ragel/xmlcodegen.cpp	(revision 3695)
+++ ragel/xmlcodegen.cpp	(working copy)
@@ -246,6 +246,9 @@
 	case InlineItem::Break:
 		out << "<break></break>";
 		break;
+	case InlineItem::Ret: 
+		out << "<ret></ret>";
+		break;
 	default: break;
 	}
 
@@ -360,12 +363,9 @@
 		case InlineItem::Goto: case InlineItem::GotoExpr:
 		case InlineItem::Call: case InlineItem::CallExpr:
 		case InlineItem::Next: case InlineItem::NextExpr:
-		case InlineItem::Break:
+		case InlineItem::Break: case InlineItem::Ret: 
 			writeWithContext( item, context );
 			break;
-		case InlineItem::Ret: 
-			out << "<ret></ret>";
-			break;
 		case InlineItem::PChar:
 			out << "<pchar></pchar>";
 			break;
