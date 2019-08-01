using Test
using Animations
using Observables
using Colors: Color, RGB, weighted_color_mean

@testset "keyframes" begin

    kf1 = Keyframe(1, 5.0)
    kf2 = Keyframe(3, 10.0)
    kf3 = Keyframe(6, 0.0)

    animation = Animation(
        [kf1, kf2, kf3],
        [Easing(type=SineEasing), Easing(type=LinearEasing)]
    )

    on(animation) do x
        println(x)
    end
    update!.(animation, [0, 1, 2, 3, 4, 5, 6, 7])
end

@testset "vector interpolate" begin

    kf1 = Keyframe(0, [0.0, 0.0, 0.0])
    kf2 = Keyframe(1, [1.0, 2.0, 3.0])

    animation = Animation(
        [kf1, kf2],
        Easing(type=SineEasing)
    )

    on(animation) do x
        println(x)
    end
    update!.(animation, [0, 0.25, 0.5, 0.75, 1])

end

@testset "color interpolate" begin

    kf1 = Keyframe(0, RGB(0.0, 0, 0))
    kf2 = Keyframe(1, RGB(1, 0.5, 0.3))

    animation = Animation(
        [kf1, kf2],
        Easing(type=SineEasing)
    )

    on(animation) do x
        println(x)
    end

    # add correct linear interpolation method
    Animations.linear_interpolate(fraction::Real, c1::Color, c2::Color) = weighted_color_mean(fraction, c1, c2)

    update!.(animation, [0, 0.25, 0.5, 0.75, 1])

end

@testset "string steps" begin

    kf1 = Keyframe(0, "first")
    kf2 = Keyframe(1, "second")
    kf3 = Keyframe(2, "third")

    animation = Animation(
        [kf1, kf2, kf3],
        Easing(type=Step)
    )

    on(animation) do x
        println(x)
    end

    update!.(animation, [0, 0.5, 1, 1.5, 2])

end
