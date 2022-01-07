import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "one" $ it "works" $ 1 `shouldBe` (1 :: Int)
