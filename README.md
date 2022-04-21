# bodyposenet-on-tao-toolkit
bodyposenet-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて BodyPoseNet の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- BodyPoseNet
- Docker
- TensorRT Runtime

## BodyPoseNetについて
BodyPoseNet は、骨格予測のための、画像内における複数人の姿勢推定を行うAIモデルです。  

## 動作手順

### engineファイルの生成
BodyPoseNet のAIモデルをデバイスに最適化するため、BodyPoseNet の .etlt ファイルを engine file に変換します。  
現時点におけるNVIDIAの仕様では、GPUのアーキテクチャごとに engine file の生成が必要です。  
つまり、あるサーバで生成した engine file を別のサーバーにそのまま適用することはできません。  
本レポジトリに格納された bodyposenet.engine は、実際に生成される engine file の参考例です。  
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
	docker exec -it bodyposenet-tao-tool-kit tao-converter -k nvidia_tlt \
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された BodyPoseNet の AIモデルを Deep Stream 上で動作させる手順は、[bodyposenet-on-deepstream](https://github.com/latonaio/bodyposenet-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである bodyposenet.engine は、[bodyposenet-on-deepstream](https://github.com/latonaio/bodyposenet-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  
